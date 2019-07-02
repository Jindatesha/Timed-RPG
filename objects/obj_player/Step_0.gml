/// @description Insert description here
// You can write your code in this editor



#region controls
var move_left = keyboard_check(ord("A"));
var move_right = keyboard_check(ord("D"));
var move_up = keyboard_check(ord("W"));
var move_down = keyboard_check(ord("S"));


var dodge_roll = keyboard_check_pressed(vk_space);

var use_weapon = mouse_check_button_pressed(mb_left);
var use_weapon_special = mouse_check_button(mb_right);

var pick_up_item = keyboard_check_pressed(ord("E"));

var use_utility_item = keyboard_check_pressed(ord("Q"));

var call_inventory = keyboard_check_pressed(vk_tab);

var pick_up_item = keyboard_check_pressed(ord("E"));





var trying_to_move_in_any_direction = false;

if move_left > 0 or move_right > 0 or move_up > 0 or move_down > 0 
{
	trying_to_move_in_any_direction = true;
}


var reduce_speed = 1;

if can_control_player == false 
{
	reduce_speed = 0;
}

var h_speed = ((move_right - move_left) * move_speed) * reduce_speed;
var v_speed = ((move_down - move_up) * move_speed) * reduce_speed;



#endregion



#region switching hands for holding weapon and image scale based on mouse_dir


//mouse direction
if can_switch_state == true
{

		
	mouse_dir = point_direction(x,y,mouse_x,mouse_y);
	
		//switch hands and all sprites
		
		
		switch(weapon_hand)
		{
			//left hand
			case -1:
			

				if mouse_dir < (90 - switch_hand_degree_margin) or mouse_dir > (270 + switch_hand_degree_margin)
				{
					//switch hands
					image_xscale = 1;
					weapon_hand = 1;
					hand_dir = mouse_dir;
					
				}
				else
				{
					hand_dir = clamp(mouse_dir,135,225);
				}
				
			break;
			
			//right hand
			case 1:
			
				
				
				//if we are passed our threshold...switch hands
				if  mouse_dir > (90 + switch_hand_degree_margin) and mouse_dir < (270 - switch_hand_degree_margin)
				{
					image_xscale = -1;
					weapon_hand = -1;
					hand_dir = mouse_dir;
				}
				else
				{
					if mouse_dir < (45 + switch_hand_degree_margin)
					{
						hand_dir = clamp(mouse_dir,0,45);
					}
					else
					{
						hand_dir = clamp(mouse_dir,225,360);
					}
				}
				
			break;
		}
		
	
}
#endregion


if global.freeze_character == false
{
#region idle
if can_switch_state == true and is_dodge_rolling == false
{
	 //what state am I in?
	current_state = STATE.IDLE;
}
#endregion



#region dodgeroll
if can_switch_state == true and dodge_roll > 0 and trying_to_move_in_any_direction == true and can_control_player == true
{
	dodge_roll_dir = point_direction(x,y,x + h_speed, y + v_speed);
	is_dodge_rolling = true;

	//what image* direction to dodge roll in ...setting it back in alarm0	
	x_scale_before_dodge_roll = image_xscale;
	
	if move_left > 0 and move_right != 1
	{
		image_xscale = -1;
	}
		
	if move_right > 0 and move_left != 1
	{
		image_xscale = 1;
	}
	
	

	
	current_state = STATE.DODGE_ROLL;
	
	
	
	
	can_switch_state = false;
	can_control_player = false;	
	image_index = 0;
	alarm[0] = round((sprite_get_number(sprite_state_array[STATE.DODGE_ROLL])) * 4);
	
	//now that we are dodge rolling, dont show the players weapon
	my_weapon.visible = false;
	
	
}



if can_control_player == true
{
	
	olde_h_speed = h_speed;
	olde_v_speed = v_speed;
}
else
{
	if is_dodge_rolling == true
	{
		//add to our h/v speeds
		h_speed = olde_h_speed + lengthdir_x(dodge_roll_speed,dodge_roll_dir);
		v_speed = olde_v_speed + lengthdir_y(dodge_roll_speed,dodge_roll_dir);
	}

}



#endregion


#region attacks/ weapon use & special


#region basic attack
//if use weapon ....... and can attack (combo is 3)
if use_weapon > 0 and my_weapon.can_attack == true 
{
	my_weapon.launch_attack = true;
	my_weapon.has_done_hit_collisions = false;
	global.player_has_attacked = true;
	attack_thrust_current_frame = 0;
	can_control_player = false;
}


if global.player_has_attacked == true
{
	attack_thrust_current_frame += 1;
	
	h_speed += lengthdir_x(ceil(attack_thrust_amount/attack_thrust_total_frames),mouse_dir);
	v_speed += lengthdir_y(ceil(attack_thrust_amount/attack_thrust_total_frames),mouse_dir);
	
	if attack_thrust_current_frame >= attack_thrust_total_frames
	{
		global.player_has_attacked = false;
		
		attack_thrust_current_frame = 0;
	}
}
#endregion



#region special

special_attack_cooldown_timer -= 1;
special_attack_cooldown_timer = clamp(special_attack_cooldown_timer,0,max_special_attack_cooldown_time);

if special_attack_cooldown_timer <= 0 is_special_attack_on_cooldown = false;


if use_weapon_special and my_weapon.can_attack == true and is_special_attack_on_cooldown == false and has_cast_spell == false
{
	is_casting_spell[0] = true;
	which_spell = 0;
	is_special_attack_on_cooldown = true;	
	//can_control_player = false;
	//can_switch_state = false;
	

	
}



//if a button has been pressed and held for casting a spell...
if is_casting_spell[0] or is_casting_spell[1] or is_casting_spell[2]
{
		
	switch(which_spell)
	{
		//special attack
		default:
		case 0:
			//which special attack will depend what weapon you have
			
			if use_weapon_special == 0 and has_cast_spell == false
			{		
				current_state = STATE.ATTACK_SPECIAL;
				has_cast_spell = true;
				can_control_player = false;
				can_switch_state = false;
				is_casting_spell[0] = false;
				special_attack_cooldown_timer = max_special_attack_cooldown_time;



				alarm[0] = special_attack_time_till_player_can_move;
				alarm[1] = max_special_attack_cooldown_time;
				//warp to location (in direction of mouse)
				var dir_of_mouse = point_direction(x,y,mouse_x,mouse_y);
				
				
				//before we actually move...check for collisions to see about who is getting hit
				with (instance_create_depth(x,y,depth,obj_hit_collision))
				{
					image_angle = dir_of_mouse;
					sprite_index = spr_ability_dash_arrow_tail;
					
					var final_damage = other.my_damage * random_range(1,ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.MAX_WEAPON_DAMAGE_SCALE,other.my_weapon.my_weapon_number)) * 4;							
					
					var hit_list = ds_list_create();
					var hit_count = instance_place_list(x,y,obj_enemy,hit_list,true);
					var i = 0;
					repeat(hit_count)
					{
						with (ds_list_find_value(hit_list,i))
						{				
							final_damage = floor(final_damage);
							var crit_number_needed = 97;
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
							scr_damage_numbers(hp_lossed,dir_of_mouse,has_crit);
				
					
						}
				
						i += 1;
					}
	
					ds_list_destroy(hit_list);
	
					instance_destroy();
	
				}
	
						
				
				
				
				h_speed += lengthdir_x(length_of_dash,dir_of_mouse);
				v_speed += lengthdir_y(length_of_dash,dir_of_mouse);
				
				//mask_index = spr_player_collision_mask;
			}

			
			
		break;
		
		//utility item : dummy
		case 1:
		
		break;
		
		
		//utility item: grappling hook
		case 2:
		
		break;
	}
}


#endregion



#endregion



#region horizontal/vertical movement & collision

//break up the movement collision into chunks (over several steps instead of one potentially skipping over a solid)
//h_speed += over_fill_for_h_speed;
//v_speed += over_fill_for_v_speed;

//h_speed = (abs(h_speed) - 32)//its obj_solids width

if (abs(v_speed) or abs(h_speed)) > 0 and is_dodge_rolling == false
{
	current_state = STATE.WALK;
}


//horizontal
if place_meeting(x + h_speed, y,obj_solid)
{
	while (!place_meeting(x + sign(h_speed), y,obj_solid))
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

}



#region Inventory


//if we press the inventory button
if call_inventory > 0 
{
	 //switch between on or off
	 inventory_on *= -1;
	 
	 
	//if we are displaying inventory
	if inventory_on == 1
	{
		//make sure the ui is on top of everything
		depth = DEPTH.SMALLEST - 1;
	
		//make cursor depth lower than us
		obj_cursor.depth = depth - 1;
	
		//make sure sword doesnt get shown
		my_weapon.visible = false;
	
		//make sure camera stops moving around
		global.can_move_towards_mouse = false;
		//make sure player cant move or attack
		global.freeze_character = true;
		//set the position for the ui
		starting_inventory_x = view_x + ((view_w - sprite_get_width(spr_inventory_backing))/2);
		starting_inventory_y = view_y + ((view_h - sprite_get_height(spr_inventory_backing))/2);

		
		instance_create_depth(starting_inventory_x,starting_inventory_y,depth,obj_inventory_bag_collision);
			
			

		//create all the items inside the inventory for us to be able to grab and do stuff with
		var how_many_items_in_inventory_pre = ds_list_size(inventory_list);
		//var item_slots_filled = 0;
		for(var i = 0; i < how_many_items_in_inventory_pre; i+=1;)
		{
			//obj_item_in_inventory
			var this_item = ds_list_find_value(inventory_list,i);
			if this_item != -1
			{				
				
				
				//create and place the visual item
				with (instance_create_depth(starting_inventory_x + inventory_slots_pos_array[i,0],starting_inventory_y + inventory_slots_pos_array[i,1],depth - 1,obj_item_in_inventory))
				{
					//create an enum sprite list for weapons and for equipment					
					my_item_number = ds_list_find_value(other.inventory_list,i);					
					
					// based on item number; what class and sprite_index are you?										
					sprite_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.SPRITE_INDEX,my_item_number);		
					image_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.IMAGE_INDEX,my_item_number);
					my_item_class = ds_grid_get(global.item_database_grid,THIS_ITEMS.ITEM_CLASS,my_item_number);					
					
	
					image_speed = 0;
					
					current_inventory_slot = i;
					slot_placement_x = obj_player.inventory_slots_pos_array[i,0];
					slot_placement_y = obj_player.inventory_slots_pos_array[i,1];
					
				}
								
			}
			
			
			
			//create and place a collision box for an invisible check to see if an item can be moved here
			with (instance_create_depth(starting_inventory_x + inventory_slots_pos_array[i,0],starting_inventory_y + inventory_slots_pos_array[i,1],depth - 1,obj_check_inventory_slot))
			{
				current_inventory_slot = i;
				//class
				slot_placement_x = obj_player.inventory_slots_pos_array[i,0];
				slot_placement_y = obj_player.inventory_slots_pos_array[i,1];
				
				
				
				
				
				/*
				0 = wep 1
				1 = wep 2

				2 = glove
				3 = ring
				4 = boots

				5 = helmet
				6 = torso
				7 = legs

				8 -> ?? = left -> right then down one row
				ie:
				8,9,10
				11,12,13
				*/
				switch(i)
				{
					default:
					case 0: 
						my_slot_class = ITEM_CLASS.WEAPON;
					break;
					
					case 1: 
						my_slot_class = ITEM_CLASS.WEAPON;
					break;
					
					case 2: 
						my_slot_class = ITEM_CLASS.GLOVES;
					break;
					
					case 3: 
						my_slot_class = ITEM_CLASS.RING;
					break;
					
					case 4: 
						my_slot_class = ITEM_CLASS.BOOTS;
					break;
					
					case 5: 
						my_slot_class = ITEM_CLASS.HELMET;
					break;
					
					case 6: 
						my_slot_class = ITEM_CLASS.TORSO;
					break;
					
					case 7: 
						my_slot_class = ITEM_CLASS.PANTS;
					break;
					
					case 8: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 9: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 10: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 11: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 12: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 13: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 14: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 15: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 16: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
				}
					
			}
			
			
		
		}
		
		


	}
	else
	{
		//make sure the ui is on top of everything
		depth = starting_depth;
	
		//make cursor depth lower than us
		obj_cursor.depth = obj_cursor.starting_depth;
	
		//make sure sword doesnt get shown
		my_weapon.visible = true;
	
		//make sure camera stops moving around
		global.can_move_towards_mouse = true;
		
		//make sure player cant move or attack
		global.freeze_character = false;
		
		//get rid of inventory collision box 
		
		with (obj_inventory_bag_collision)
		{
			instance_destroy();
		}
		
		
		//get rid of all the objects that we can grab
		with (obj_item_in_inventory)
		{
			instance_destroy();
		}
		
		//get rid of all the slot location objects
		with (obj_check_inventory_slot)
		{
			instance_destroy();
		}
	}
}
#endregion


#region Item Pickup

if pick_up_item > 0
{

	var hit_list = ds_list_create();
	var hit_count = instance_place_list(x,y,obj_item_on_floor,hit_list,true);

	if hit_count > 0
	{
		//see where the nearest empty slot is...if not present then cant pickup
		var current_total_slots = ds_list_size(inventory_list) - 8;
		for(var i = 0; i < current_total_slots; i += 1;)
		{
			//check to see if this slot is empty (-1)
			if ds_list_find_value(inventory_list,i + 8) == -1
			{
				//we found an empty slot to put our new item in...leave this loop
				ds_list_replace(inventory_list,i + 8,ds_list_find_value(hit_list,0).my_item_number);
			
			
				//destroy that item on the floor so we cant keep picking it up
				with (ds_list_find_value(hit_list,0))
				{		
					//destroy item so it cant be picked up again
					instance_destroy();
				}			
				
				break;
			}
		
		}

	}

	
	//no item slots available but still clean up your list			
	ds_list_destroy(hit_list);
	
}

#endregion



#region Die

//LATER: make sure to save any achievements

//LATER: go into a death animation with a spotlight on you...then a menu comes with stats and was killed by:  ie: enter the gungeon


if my_hp <= 0
{

	//LATER: dont simply restart the whole game...but go back to a certain menu
	game_restart();

}



#endregion





//finally set our sprites image
sprite_index = sprite_state_array[current_state];













