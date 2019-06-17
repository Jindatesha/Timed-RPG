/// @description Insert description here
// You can write your code in this editor


h_speed = 0;
v_speed = 0;


//die...
if my_hp <= 0
{
	
	//drop some mats
	var chosen_item = irandom_range(0,100);
	var has_found_items_to_drop = false;
	var item_number = 0;
	var monster_list = ds_list_find_value(global.monster_drop_list,my_monster_type);
	
	do
	{
		chosen_item -= ds_list_find_value(monster_list,item_number);
		
		if chosen_item <= 0
		{
			has_found_items_to_drop = true;
		}
		else
		{
			item_number += 2;
		}
	}
	until (has_found_items_to_drop == true);
	
	
	var found_MATERIAL_LIST_list = ds_list_find_value(monster_list,item_number + 1);
	//now that we know the items we wish to drop...drop them
	for(var i = 0; i < ds_list_size(found_MATERIAL_LIST_list); i += 1;)
	{
		var what_item_image_to_use = ds_list_find_value(found_MATERIAL_LIST_list,i);
		if what_item_image_to_use != MATERIAL_LIST.NOTHING
		{		
			with (instance_create_depth(x + (30 * i),y + (30 * i),depth,obj_item_on_floor))
			{
				sprite_index = spr_all_materials;
				image_index = what_item_image_to_use;
				my_item_number = scr_get_item_number(sprite_index,image_index);
			}
		}
	}
	
	
	
	
	
	
	//add it to the obj_spawners list with these variables..to be respawned in later
	with (obj_enemy_spawner)
	{
		
		ds_list_add(spawner_enemy_list,other.object_index);
		ds_list_add(spawner_enemy_list,current_room_number);
		ds_list_add(spawner_enemy_list,other.my_respawn_rate);
	}
	
	
	
	
	
	//grant the player some experience
	with(obj_player)
	{
		my_current_exp += other.my_death_exp_reward;
	}
	
	
	
	
	
	
	//get rid of this instance
	instance_destroy();
	
	
	
	
}













