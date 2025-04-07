shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 0.5);
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;
uniform float border_size : hint_range(0.0, 0.5) = 0.05;  // Defines the border size (0.0 to 0.5)
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Sample the texture of the panel itself
    vec4 orig_tex = texture(TEXTURE, UV);

    // Sample the blurred texture from the screen
    vec4 blurred_texture = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount);

	if (UV.x < border_size || UV.x > 1.0 - border_size || UV.y < border_size || UV.y > 1.0 - border_size){
        COLOR = orig_tex;
	}
	else {
        // Apply the blur effect with the tint color for the inner region
        COLOR = mix(blurred_texture, tint_color, tint_color.a);
        COLOR.a = orig_tex.a;  // Preserve the alpha from the original texture
    }
}
