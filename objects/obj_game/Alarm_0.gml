/// @description Insert description here
// You can write your code in this editor


//now that we have faded in all the way, allow player to move again


has_started_fading = false;

my_alpha = 1.3;

global.freeze_character = false;


obj_player.my_weapons[obj_player.current_weapon].visible = true;
obj_player.can_switch_state = true;











