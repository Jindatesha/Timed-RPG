/// @description Insert description here
// You can write your code in this editor

//controls
var exit_game = keyboard_check_pressed(vk_escape);
var restart_game = keyboard_check_pressed(ord("R"));




if exit_game > 0
{
	game_end();
}


if restart_game > 0
{
	game_restart();
}







