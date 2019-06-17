/// @description Insert description here
// You can write your code in this editor

var button_up = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var button_down = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

button_select_pushed = keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("E"));




var button_dir = (button_up - button_down); //1, 0 , -1


switch(button_dir)
{
	default:
	case 0:
	
	break;
	
	case 1:
		//move option up
		hovered_option -= 1;
		if hovered_option < 0 hovered_option = 1;
	break;
		
	
	case -1:
		//move option down
		hovered_option += 1;
		if hovered_option > 1 hovered_option = 0;
	break;
	
	
}



//dont allow the player to move or attack or change states
if instance_exists(obj_player)
{
	obj_player.my_weapons[obj_player.current_weapon].visible = false;
	obj_player.can_switch_state = false;
	global.freeze_character = true;
	obj_player.current_state = STATE.WALK;
	
}












