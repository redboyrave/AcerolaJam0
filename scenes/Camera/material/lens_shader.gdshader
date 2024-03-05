shader_type spatial;

uniform sampler2D _depth:hint_depth_texture;

uniform vec3 shallow_color:source_color;
uniform vec3 deep_color:source_color;
uniform float depth_blend:hint_range(0.0, 1.0) = .25;

void vertex() {
	vec3 world_position = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	// Called for every vertex the material is visible on.
}

void fragment() {
	float depth = texture(_depth,SCREEN_UV,0.0).r;
	vec3 ndc = vec3((SCREEN_UV*2.0) - 1.0,depth);
	vec4 world =  INV_PROJECTION_MATRIX * vec4(ndc,1.0);
	float world_depth_z = -world.z / world.w;
	float vertex_z = -(INV_VIEW_MATRIX * vec4(VERTEX,1.0)).z;
	float horizontal_depth = vertex_z - world_depth_z;
	float depth_fade_blend= exp(-horizontal_depth / depth_blend);
	depth_fade_blend = clamp(depth_fade_blend,0.0,1.0);
	// Called for every pixel the material is visible on.
	ALBEDO = mix(shallow_color,deep_color,depth_fade_blend);
	ROUGHNESS = 0.1;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
