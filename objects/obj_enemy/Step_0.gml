/// @description Insert description here
// You can write your code in this editor


var h_speed = 0;
var v_speed = 0;


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
				sprite_index = spr_item_drop_materials;
				image_index = what_item_image_to_use;
				my_item_number = scr_get_item_number(sprite_index,image_index);
			}
		}
	}
	
	
	
	
	
	
	
	with (obj_enemy_spawner)
	{
		ds_list_add(spawner_enemy_list,other.id);
		ds_list_add(spawner_enemy_list,other.my_respawn_rate);
	}
	
	//random_location ...take into account our sprite (prevent us from getting stuck in walls)
	do
	{
		x = irandom_range(0 + sprite_width,room_width - sprite_width);
		y = irandom_range(0 + sprite_width,room_height - sprite_width);
	}
	until(!place_meeting(x,y,obj_solid) and (point_distance(x,y,obj_player.x,obj_player.y) > 200) and (place_meeting(x,y,obj_spawn_area)))
	
	my_hp = my_max_hp;
	hp_lossed = 0;
	show_health_timer = 0;
	
	
	instance_deactivate_object(id);
	
}






//if we are within range of the player...
if distance_to_object(obj_player) <= my_range
{
	//start walking over to the player...to attack
	var x_dif = obj_player.x - x;
	var y_dif = obj_player.y - y;
	h_speed = min(abs(x_dif),my_speed) * sign(x_dif);
	v_speed = min(abs(y_dif),my_speed) * sign(y_dif);
	//move_towards_point(obj_player.x,obj_player.y,my_speed);
	
	
	if distance_to_object(obj_player) <= my_attack_range
	{
		if can_attack == true
		{
			can_attack = false;
			alarm[0] = my_attack_reload_time;
			can_move = false;
			can_switch_state = false;		
			is_attacking = true;
		}
	}
	
	
}



if is_attacking == true
{

	if has_done_hit_collisions == false
	{
		
		if floor(image_index) == 3 //global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.COLLISION_NUMBER]
		{			
				
			has_done_hit_collisions = true;
	
			direction = point_direction(x,y,obj_player.x,obj_player.y);
			
			with instance_create_depth(x + lengthdir_x(sprite_width,direction),y + lengthdir_y(sprite_width,direction),depth,obj_enemy_attack_collision)
			{
				my_damage = other.my_damage;
				sprite_index = other.my_attack_collision_image;
				direction = other.direction;
				image_angle = direction;				
			}
			
	
		}
	
	}

}




#region horizontal/vertical movement & collision

//horizontal
if place_meeting(x + h_speed, y,obj_solid)
{
	while !place_meeting(x + sign(h_speed), y,obj_solid)
	{
		x += sign(h_speed);			
	}
	
	h_speed = 0;
}
else
{
	x += h_speed;	
}



//vertical movement
if place_meeting(x, y + v_speed,obj_solid)
{
	while !place_meeting(x, y + sign(v_speed),obj_solid)
	{
		y += sign(v_speed);
	}
	
	v_speed = 0;
}
else
{
	y += v_speed;
}


#endregion






