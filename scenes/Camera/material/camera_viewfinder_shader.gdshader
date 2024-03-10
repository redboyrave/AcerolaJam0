// NOTE: Shader automatically converted from Godot Engine 4.2.1.stable's StandardMaterial3D.
// Modified
shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

group_uniforms Pixelation;
uniform int pixelation_ammount:hint_range(1,10) = 1;

group_uniforms Albedo;
uniform sampler2D texture_albedo : source_color,filter_linear_mipmap,repeat_enable;
uniform float emission_strength = 1;
group_uniforms Roughness;
uniform float min_rough:hint_range(0,1) = 0;
uniform float max_rough:hint_range(0,1) = 1;
uniform sampler2D texture_roughness : hint_roughness_gray,filter_linear_mipmap,repeat_enable;
group_uniforms Metallic;
uniform sampler2D texture_metallic : hint_default_white,filter_nearest,repeat_enable;
uniform vec4 metallic_texture_channel;
uniform float specular;
uniform float metallic;
group_uniforms uvs;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}

vec3 pixelate(sampler2D image, vec2 uv, float ammount){
	ivec2 size = textureSize(image,0);
	vec2 fac = vec2(size)/(ammount);

	vec2 new_uv = round(uv* fac)/ fac;
	vec4 t = texture(image,new_uv);
	return t.rgb;
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	//ALBEDO = albedo_tex.rgb;
	ALBEDO = pixelate(texture_albedo,UV,float(pixelation_ammount));
	EMISSION = pixelate(texture_albedo,UV,float(pixelation_ammount))*emission_strength;
	float metallic_tex = dot(texture(texture_metallic,base_uv),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	vec4 roughness_texture_channel = vec4(0.333333,0.333333,0.333333,0.0);
	float roughness_tex = dot(texture(texture_roughness,base_uv),roughness_texture_channel);
	ROUGHNESS = mix(min_rough,max_rough,roughness_tex);
	SPECULAR = specular;
}
