/// @description Insert description here
// You can write your code in this editor


with (obj_player)
{
	image_xscale = (sign(other.x - (room_width/2)));
}



if has_started_fading == false
{
	
	with (obj_player)
	{
		image_xscale = (sign(other.x - (room_width/2)));
		my_weapon.visible = false;
		current_state = STATE.WALK; 
		can_switch_state = false;
	}
	
	
global.freeze_character = true;
has_started_fading = true;
	
	
	alarm[0] = fade_out_max_time;
}

	


