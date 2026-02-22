shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec4 dark_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform bool monochrome_1bit = false;
uniform float threshold : hint_range(0.0, 1.0) = 0.5;

// NEW
uniform int bit_depth : hint_range(1, 8) = 5;

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);

	if (monochrome_1bit) {
		// True 1-bit mode (based on luminance, not per channel)
		float luminance = dot(color.rgb, vec3(0.299, 0.587, 0.114));
		float stepped = step(threshold, luminance);
		color.rgb = vec3(stepped);
	} else {
		// Multi-bit quantization
		float levels = pow(2.0, float(bit_depth));
		color.rgb = floor(color.rgb * levels) / (levels - 1.0);
	}

	// Remap between dark/light tint
	color.rgb = mix(dark_color.rgb, light_color.rgb, color.rgb);

	COLOR = color;
}
