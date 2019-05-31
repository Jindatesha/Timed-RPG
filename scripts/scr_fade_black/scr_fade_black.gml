/// @param in_out
/// @param max_fade_out_time

//fade in = -1
//fade_out = 1

var in_out = argument[0];
var fade_out_max_time = argument[1];



if instance_exists(obj_player)
{
	obj_player.my_weapons[obj_player.current_weapon].visible = false;
	obj_player.can_switch_state = false;
}

//prevent the screenshake from continuing passed one attack
global.player_has_attacked = false;

global.transition_fade_alpha += in_out/fade_out_max_time;
global.transition_fade_alpha = clamp(global.transition_fade_alpha,0,1);
draw_sprite_stretched_ext(spr_black,0,view_x,view_y,view_w,view_h,c_white,global.transition_fade_alpha);
	
	
	
	
	
	
	
	
	