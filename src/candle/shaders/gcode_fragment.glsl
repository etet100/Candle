#version 130

#ifdef GL_ES
// Set default precision to medium
precision mediump int;
precision mediump float;
#endif

//Dash grid (px) = factor * pi;
// const float factor = 2.0;

in vec4 v_color;
in vec3 v_normal;
in vec3 v_light_direction;
in vec3 v_eye;

uniform sampler2D u_texture;
uniform bool u_shadow;

//out vec4 fragColor;

// bool isNan(float val)
// {
//     return (val > 65535.0);
// }

void main()
{
    if (u_shadow) {
        gl_FragColor = vec4(1.0);
        return;
    }

    vec3 lightColor = vec3(0.5, 0.0, 0.5);

    // Draw dash lines
    // if (!isNan(v_start.x)) {
    //     vec2 sub = v_position - v_start;
    //     float coord = length(sub.x) > length(sub.y) ? gl_FragCoord.x : gl_FragCoord.y;
    //     if (cos(coord / factor) > 0.0) discard;
    // }

    vec3 viewDir = normalize(-v_eye);

    // Wektor normalny (iloczyn wektorowy wektora widzenia i kierunku linii)
    vec3 normal = normalize(cross(viewDir, v_normal));

    // calc diffuse light
    float diff = max(dot(v_normal, v_light_direction), 0.0);

    // calc specular light
    vec3 reflectDir = reflect(-v_light_direction, v_normal);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32.0);

    // calc fragment color
    gl_FragColor = vec4(v_color.rgb * (diff + 0.3) + spec, v_color.a);
}
