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
if launch_attack == true
{
	
	launch_attack = false;
	chain_attack_window = max_chain_attack_window;
	check_to_see_if_player_attacks_again_within_window = false;
	
	image_speed = my_attack_image_speed;
	can_attack = false;
	
	if has_already_attacked == true
	{
		attack_count += 1;
		
		
		//clamp attack count for combos...up to 3 attacks
		attack_count = clamp(attack_count,0,2);
		
		//change sprite to use combo X basic attack
		sprite_index = ds_grid_get(global.weapons_grid,(WEAPON_ATTRIBUTE.BASIC_ATTACK_1) + (attack_count),my_weapon_number);

	}
	
}




if has_done_hit_collisions == false
{
		
	if floor(image_index) == 3//image_number_to_spawn_hit_collider
	{
			
				
		has_done_hit_collisions = true;
	
		var hit_list = ds_list_create();
		var hit_count = instance_place_list(x,y,obj_enemy,hit_list,true);
		var i = 0;
		repeat(hit_count)
		{
			with (ds_list_find_value(hit_list,i))
			{
				
				var final_damage = obj_player.my_damage * random_range(1,ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.MAX_WEAPON_DAMAGE_SCALE,other.my_weapon_number));
				final_damage = floor(final_damage);
				var crit_number_needed = 100 - obj_player.my_stats_array[PLAYER_STATS.CRIT_CHANCE];
				var crit = irandom_range(0,100);
				var has_crit = false;
				
				if crit_number_needed - crit  <= 0
				{
					//then we did crit
					has_crit = true;
					final_damage *= 2; 
					final_damage = floor(final_damage);
				}
				
				my_hp -= final_damage;
				show_health_timer = show_health_max_time;
				hp_lossed = final_damage;
				scr_knock_back(other.my_knockback_amount,other.image_angle);				
				scr_damage_numbers(hp_lossed,other.image_angle,has_crit);
				
					
			}
				
			i += 1;
		}
	
		ds_list_destroy(hit_list);
	
	}
	
}






//check to see if animation for this basic attack is done and we are attacking...
if image_index > image_number - 1
{
	check_to_see_if_player_attacks_again_within_window = true;	
}




if check_to_see_if_player_attacks_again_within_window == true
{
	has_already_attacked = true;
	image_speed = 0;
	image_index = image_number - 2;
		
		
		
	chain_attack_window -= 1;
		
	if chain_attack_window <= 0
	{
		image_index = 0;
		can_attack = false;
		check_to_see_if_player_attacks_again_within_window = false;
		var atk_cooldown = ds_grid_get(global.weapons_grid,(WEAPON_ATTRIBUTE.BASIC_ATTACK_COOLDOWN),my_weapon_number) * room_speed;	
		alarm[0] = atk_cooldown + 1;
	}
	else
	{
		//are we at max combo? ...if not then we have an opportunity to attack again to add to the basic atk combo
		if attack_count < 2
		{
			can_attack = true;
		}
			
	}
		
}
	
	
		
		
