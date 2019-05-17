/// @description Insert description here
// You can write your code in this editor

//controls
var exit_game = keyboard_check_pressed(vk_escape);
var restart_game = keyboard_check_pressed(ord("R"));
var spawn_item = keyboard_check_pressed(vk_down);



if exit_game > 0
{
	game_end();
}


if restart_game > 0
{
	game_restart();
}



if spawn_item > 0
{
	with (instance_create_depth(obj_player.x,obj_player.y,DEPTH.ITEM_ON_FLOOR,obj_item_on_floor))
	{
		
		my_item_number = irandom_range(0, HELMETS_LIST.LAST_IN_LIST - 1);
		scr_get_variables_from_item_number();		
		image_index = my_item_number - last_item_number;
		
	}

}





