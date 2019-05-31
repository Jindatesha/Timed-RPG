/// @description Insert description here
// You can write your code in this editor




if global.time >= global.time_until_boss
{
	
	if has_spawned_boss == false
	{
		has_spawned_boss = true;
	
		//spawn the player to a room...and have the player face the boss
		var spawn_player_to_x = 2600;
		var spawn_player_to_y = 2200;
		obj_player.x = spawn_player_to_x;
		obj_player.y = spawn_player_to_y;
	
	
	
		var spawn_boss_to_x = 6300;
		var spawn_boss_to_y = 2200;

		instance_create_depth(spawn_boss_to_x,spawn_boss_to_y,DEPTH.PLAYER,obj_enemy_boss_slime)
	
		//go to boss room 
		room_goto(rm_boss);
	}
	
}
else
{
	
	global.time += 1;

	//draw time
	draw_text(view_x + (view_w/2),view_y + (view_h * 0.05),string(global.time div room_speed));


}










if has_started_fading == true
{
	scr_fade_black(-1,fade_in_max_time);	
}
