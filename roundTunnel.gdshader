shader_type canvas_item;
uniform sampler2D tonnel_texture;
uniform vec2 direction = vec2(-8f,2f);
uniform float speed_fly = 1f;

const float PI = 3.14159265358979323846;




vec4 tunnel_render(sampler2D text, vec2 screen_uv) {
	vec4 tex = texture(text, screen_uv);

	vec2 uv =  vec2(0.5, 0.5) - vec2(screen_uv.x, 1.0-screen_uv.y);//(screen_uv * 2f - 1f);  // move origin of UV coordinates to center of screen
	uv += vec2(0.2*sin(TIME/2f), 0.3*cos(TIME/3f)); // move center of screen
	vec3 col = vec3(0f);
	float phi = atan(uv.y,uv.x);  // get phi angle
	float rho = length(uv);  // get rho
	vec2 st = vec2(phi / (PI*2f) + 0.5,0.05/rho); // get pixel in polar coordinate system
	
	if (direction.x != 0f) {
		st.x += cos(TIME) / direction.x ;	 
	}
	
	st.y += TIME * speed_fly ;
//	if (speed_fly != 0f) {
//		st.y += TIME * speed_fly ;
//	}
	//st *= speed;
	col += texture(text,st).rgb;
	col *= rho + 0.4; // center 
	col += 0.1/rho*vec3(0.3,0.1,0f); // center light
		
	return vec4(col,1f);
}

void fragment(){

	COLOR = tunnel_render(TEXTURE,SCREEN_UV);
	
}





