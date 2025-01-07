uniform vec3 uColor;
varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambient-light.glsl
#include ../includes/directional-light.glsl
#include ../includes/point-light.glsl

void main() {
    vec3 normal = normalize(vNormal);
    vec3 color = uColor;
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    // Light
    vec3 light = vec3(0.);

    light += pointLight(
        vec3(1.0,0.1,0.1), // light color
        1.0, // light intensity
        normal, // normal
        vec3(0.0,2.5,.0), // Light Position
        viewDirection,
        20.0, // Specular power
        vPosition, // Fragment Position,
        0.25 // Light decay
    );

    light += directionalLight(
        vec3(.1, 0.1, 1.),
        1., 
        normal, 
        vec3(0.0, 0.0, 3.0),
        viewDirection,
        30.
    );
    light += ambientLight(vec3(1.0), .01);
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}