shader_type spatial;
render_mode unshaded,cull_disabled;

uniform sampler2D screen_text:hint_screen_texture,filter_nearest,repeat_enable;
uniform float offset_ammount:hint_range(0,5) = 1;


vec2 randomize(float seed){
	return vec2(
		fract(sin(dot(seed,5.49875324))),
		fract(tan(pow(seed,2))*6853.864853)
	);
}

void vertex(){
	COLOR.xz = randomize(float(INSTANCE_ID));

}

void fragment(){
	ALBEDO = texture(screen_text,SCREEN_UV+(COLOR.xz) * offset_ammount).rgb;
	float alpha_circle = 1.0 - clamp(length(UV-0.5)*2.,0,1);
	//ALBEDO = vec3(alpha_circle);
	ALPHA = pow(alpha_circle,1.25);
	ALPHA_HASH_SCALE = alpha_circle *.5;
	//ALPHA = texture(screen_text,SCREEN_UV).a;
}