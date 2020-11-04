uniform float time;
uniform float progress;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform vec4 resolution;
varying vec2 vUv;
varying vec3 vPosition;
uniform float playhead;

void main(){
    vec3 color1=vec3(.51,.32,.42);
    vec3 color2=vec3(.86,.8,.73);
    
    float pi=3.1415926;
    float fline=sin(vUv.y*6.*pi);
    
    float treshold=.05;
    
    float fline_a=abs(fline);
    
    float k=0.;
    float sk=0.;
    
    if(fline<0.){
        k=-1.;
    }else{
        k=1.;
    }
    
    if(fline_a<treshold){
        sk=(treshold-fline_a/treshold);
        k=k*(1.*-sk)+fline_a*sk;
    }
    
    k=(k+1.)/2.;
    
    float fog=1.-clamp((vPosition.z-2.-playhead*6.)/11.,0.,1.);
    
    vec3 finalColor=mix(color1,color2,k);
    
    finalColor=mix(vec3(0.),finalColor,fog);
    
    gl_FragColor=vec4(finalColor,1.);
}
