uniform float time;
uniform float playhead;
varying vec2 vUv;
varying vec3 vPosition;
uniform vec2 pixels;

vec2 rotate(vec2 v,float a){
    float s=sin(a);
    float c=cos(a);
    mat2 m=mat2(c,-s,s,c);
    return m*v;
}

void main(){
    vUv=uv;
    vPosition=position;
    vec3 newpos=position;
    newpos.xy=rotate(newpos.xy,position.z/2.);
    gl_Position=projectionMatrix*modelViewMatrix*vec4(newpos,1.);
}
