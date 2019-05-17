/// @description Insert description here
// You can write your code in this editor

var i = 0;
repeat(ds_list_size(spawner_enemy_list)/2)
{
	ds_list_set(spawner_enemy_list,i + 1,ds_list_find_value(spawner_enemy_list, i + 1) - 1);
	
	
	if ds_list_find_value(spawner_enemy_list, i + 1) <= 0
	{
		instance_activate_object(ds_list_find_value(spawner_enemy_list, i));
		ds_list_delete(spawner_enemy_list,i);
		ds_list_delete(spawner_enemy_list,i);
	}
	else
	{
		i += 2;
	}
	
}








