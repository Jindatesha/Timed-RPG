/// @description Insert description here
// You can write your code in this editor


//allow the player to move again since all fading is done
with (obj_player)
{
					
					
	my_weapon.visible = true;
	can_switch_state = true;
	current_state = STATE.WALK;
	global.freeze_character = false;
					
	//move the player downwards
	y += 130;
				
}

global.can_move_towards_mouse = true;

//destroy ourself
instance_destroy();


