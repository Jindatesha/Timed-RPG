/// @description Insert description here
// You can write your code in this editor


//allow the player to move again since all fading is done
with (obj_player)
{
					
					
	my_weapons[current_weapon].visible = true;
	can_switch_state = true;
	current_state = potential_state[POTENTIAL_STATE.DOWN];
	global.freeze_character = false;
					
	//move the player downwards
	y += 130;
				
}

global.can_move_towards_mouse = true;

//destroy ourself
instance_destroy();


