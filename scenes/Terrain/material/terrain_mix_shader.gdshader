shader_type spatial;

group_uniforms Material_1;
uniform sampler2D diffuse_1;
uniform sampler2D roughness_1;
uniform sampler2D normal_1;
uniform float texture_scale_1 = 1.;
group_uniforms Material_2;
uniform sampler2D diffuse_2;
uniform sampler2D roughness_2;
uniform sampler2D normal_2;
uniform float texture_scale_2 = 1.;

varying vec2 _uv_1;
varying vec2 _uv_2;

void vertex() {
	_uv_1 = VERTEX.xz * texture_scale_1;
	_uv_2 = VERTEX.xz * texture_scale_2;
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec3 diff1 = texture(diffuse_1,_uv_1).rgb;
	vec3 diff2 = texture(diffuse_2,_uv_2).rgb;
	vec3 diff = mix(diff2,diff1,COLOR.r).rgb;
	ALBEDO = diff;
	float rough1 = texture(roughness_1,_uv_1).r;
	float rough2 = texture(roughness_2,_uv_2).r;
	float rough = mix(rough2,rough1,COLOR.r);
	ROUGHNESS = rough;
	vec3 norm1 = texture(normal_1,_uv_1).rgb;
	vec3 norm2 = texture(normal_2,_uv_2).rgb;
	vec3 normal = mix(norm2,norm1,COLOR.r);
	NORMAL_MAP = normal;

	//ALBEDO = vec3(n_uv,0);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
