/// @description Insert description here
// You can write your code in this editor
if has_started_to_fade == true
{
	
	if instance_exists(obj_player)
	{
		obj_player.my_hp += ((at_time_players_max_hp - at_time_players_current_hp)/max_fade_in_time);
		obj_player.my_hp = clamp(obj_player.my_hp,0,obj_player.my_max_hp);
	}
	
	scr_fade_black(fade_version,fade_time);
	
}	
	