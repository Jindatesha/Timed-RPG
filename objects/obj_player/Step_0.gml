/// @description Insert description here
// You can write your code in this editor

//controls
var move_left = keyboard_check(ord("A"));
var move_right = keyboard_check(ord("D"));
var move_up = keyboard_check(ord("W"));
var move_down = keyboard_check(ord("S"));

var dodge_roll = mouse_check_button_pressed(mb_right);

var use_weapon = mouse_check_button_pressed(mb_left);

var call_inventory = keyboard_check_pressed(vk_tab);

var pick_up_item = keyboard_check_pressed(ord("E"));





var trying_to_move_in_any_direction = false;

if move_left > 0 or move_right > 0 or move_up > 0 or move_down > 0 
{
	trying_to_move_in_any_direction = true;
}




var h_speed = (move_right - move_left) * move_speed;
var v_speed = (move_down - move_up) * move_speed;







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
#region statemachine~ normal movement
if can_switch_state == true
{
	 //what state am I in?
	current_state = STATE.WALK;
}
#endregion



#region dodgeroll
if can_switch_state == true and dodge_roll > 0 and trying_to_move_in_any_direction == true
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
	alarm[0] = round((sprite_get_number(current_state)) * 4);
	
	//now that we are dodge rolling, dont show the players weapon
	my_weapons[current_weapon].visible = false;
	
	
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



#region attack/ weapon use  
//if use weapon ....... and can attack
if use_weapon > 0 and my_weapons[current_weapon].use == false
{
	my_weapons[current_weapon].use = true;
	my_weapons[current_weapon].has_done_hit_collisions = false;
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
		can_control_player = true;
	}
}

#endregion



#region horizontal/vertical movement & collision

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
		my_weapons[current_weapon].visible = false;
	
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
		my_weapons[current_weapon].visible = true;
	
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


#region Level Up

if my_current_exp >= my_total_exp_required_till_next_level
{
	my_level += 1;//gain a level
	my_total_exp_required_till_next_level *= 1.2;// increase required exp 
	my_total_exp_required_till_next_level = round(my_total_exp_required_till_next_level);//just in case...no decimals
	my_current_exp = 0;//reset current exp
	my_spec_points += 1;
}

#endregion




//finally set our sprites image
sprite_index = sprite_state_array[current_state];



//opening node level up menu
if (keyboard_check_pressed(vk_down))
{ 	
	with (instance_create_layer(x,y,0,obj_level_up_ui))
	{
		current_player = other.id;
		changed_spec_points = other.my_spec_points;
		changed_nodes_unlocked_list = ds_list_create();
		ds_list_copy(changed_nodes_unlocked_list,other.nodes_unlocked_list);
		event_user(0);
	}
}










