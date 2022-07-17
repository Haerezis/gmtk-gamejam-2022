shader_type canvas_item;
 uniform vec4 texture_color :hint_color;
 void fragment()
{
    //vec4 texture_color = vec4(0.192156862745098, 0.6627450980392157, 0.9333333333333333, 1.0);
    
    vec4 k = vec4(TIME)*0.75;
	k.xy = UV * 5.0;
    mat3 m = mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0));
    float val1 = length(0.5-fract(k.xyz*=m*0.5));
    float val2 = length(0.5-fract(k.xyz*=m*0.3));
    float val3 = length(0.5-fract(k.xyz*=m*0.5));
    vec4 color = vec4 ( pow(min(min(val1,val2),val3), 7.0) * 3.0)+texture_color;
    vec4 text = texture(SCREEN_TEXTURE, SCREEN_UV+ color.xy/20.);
    COLOR = mix(color, text, 0.6);
}