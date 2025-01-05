uniform vec3 uColor;
varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambient-light.glsl
#include ../includes/directional-light.glsl

void main() {
    vec3 normal = normalize(vNormal);
    vec3 color = uColor;
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    // Light
    vec3 light = vec3(0.0);

    light += directionalLight(
        vec3(.1, 0.1, 1.),
        1., 
        normal, 
        vec3(0.0, 0.0, 3.0),
        viewDirection,
        30.
    );
    light += ambientLight(vec3(1.0), .03);
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}