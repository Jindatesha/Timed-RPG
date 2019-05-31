/// @description Insert description here
// You can write your code in this editor



var player_arm_length = 20;

image_angle = owner.mouse_dir;

//follow owner
x = owner.x + (22 * owner.weapon_hand) + lengthdir_x(player_arm_length, owner.mouse_dir);
y = owner.y + 12 + lengthdir_y(player_arm_length, owner.mouse_dir);



if y < owner.y
{
	depth = obj_player.depth + 1;
}
else
{
	depth = obj_player.depth - 1;
}



//you have used the weapon (attacked)
if use == true
{
	//make it animate
	image_speed = global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.IMAGE_SPEED];
	
	//collision stuff
	
	
	//check to see if animation is done
	if image_index > image_number - 1
	{
		use = false;
		image_index = 0;
		image_speed = 0;
	}
	
	
	
	if has_done_hit_collisions == false
	{
		
		if floor(image_index) == global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.COLLISION_NUMBER]
		{
			
				
			has_done_hit_collisions = true;
	
			var hit_list = ds_list_create();
			var hit_count = instance_place_list(x,y,obj_enemy,hit_list,true);
			var i = 0;
			repeat(hit_count)
			{
				with (ds_list_find_value(hit_list,i))
				{
					my_hp -= other.my_damage;
					show_health_timer = show_health_max_time;
					hp_lossed = other.my_damage;
					scr_knock_back(60,other.image_angle);
					scr_damage_numbers(hp_lossed,other.image_angle);
					
				}
				
				i += 1;
			}
	
			ds_list_destroy(hit_list);
	
		}
	
	}
}


