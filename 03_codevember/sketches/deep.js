// based on this tutorial: https://www.youtube.com/watch?v=jtXnN6-ezms&ab_channel=YuriArtyukh

// Ensure ThreeJS is in global scope for the 'examples/'
global.THREE = require('three');

// Include any additional ThreeJS examples below
require('three/examples/js/controls/OrbitControls');

const canvasSketch = require('canvas-sketch');
import fragment from './shader/fragment.glsl';
import vertex from './shader/vertex.glsl';

const settings = {
    // Make the loop animated
    animate: true,
    duration: 20,
    dimensions: [1080, 1920],
    // Get a WebGL canvas rather than 2D
    context: 'webgl',
};

const sketch = ({ context }) => {
    // Create a renderer
    const renderer = new THREE.WebGLRenderer({
        canvas: context.canvas,
    });

    // WebGL background color
    renderer.setClearColor('#000', 1);

    // Setup a camera
    const camera = new THREE.PerspectiveCamera(50, 1, 0.01, 100);
    camera.position.set(0, 0, -1);
    camera.lookAt(new THREE.Vector3());

    // Setup camera controller
    const controls = new THREE.OrbitControls(camera, context.canvas);

    // Setup your scene
    const scene = new THREE.Scene();

    let n = 500;
    const shape = new THREE.Shape();
    shape.moveTo(0, 0.2);
    for (let i = 0; i <= n; i++) {
        let theta = (2 * Math.PI * i) / n;
        let r = 0.2 + 0.2 * Math.sin((2 * theta) / 2) ** 2;
        let x = r * Math.sin(theta);
        let y = r * Math.cos(theta);
        shape.lineTo(x, y);
    }

    const extrudeSettings = {
        steps: 150,
        depth: 40,
        bevelEnabled: false,
    };

    // Setup a geometry
    const geometry = new THREE.ExtrudeGeometry(shape, extrudeSettings);
    const material = new THREE.ShaderMaterial({
        side: THREE.DoubleSide,
        uniforms: {
            time: { type: 'f', value: 0 },
            playhead: { type: 'f', value: 0 },
        },
        fragmentShader: fragment,
        vertexShader: vertex,
        // wireframe: true,
    });
    const mesh = new THREE.Mesh(geometry, material);
    scene.add(mesh);
    mesh.position.z = -1;

    // draw each frame
    return {
        // Handle resize events here
        resize({ pixelRatio, viewportWidth, viewportHeight }) {
            renderer.setPixelRatio(pixelRatio);
            renderer.setSize(viewportWidth, viewportHeight, false);
            camera.aspect = viewportWidth / viewportHeight;
            camera.updateProjectionMatrix();
        },
        // Update & render your scene here
        render({ time, playhead }) {
            mesh.position.z = -1 - playhead * 6;
            mesh.material.uniforms.playhead.value = playhead;
            controls.update();
            renderer.render(scene, camera);
        },
        // Dispose of events & renderer for cleaner hot-reloading
        unload() {
            controls.dispose();
            renderer.dispose();
        },
    };
};

canvasSketch(sketch, settings);
