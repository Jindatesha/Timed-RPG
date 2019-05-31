/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

//if we are moving items in our inventory
if place_meeting(x,y,obj_item_in_inventory) and mouse_check_button_pressed(mb_left) 
{
	sprite_index = spr_cursor_hand_grab;
	mask_index = spr_cursor_hand_grab;
	item_in_hand = instance_nearest(x,y,obj_item_in_inventory);
	item_in_hand.depth -= 1;	
}



//put it back into regular cursor when dropping the item off somewhere
if mouse_check_button_released(mb_left) and item_in_hand != -1
{
	
	
	//make sure our item has a place to go...otherwise put it back where you got it
	with(item_in_hand)
	{
		//return our depth to original so all inventory items have an equal depth
		depth += 1;
		
		//switch inv slot with other item
		if place_meeting(x,y,obj_item_in_inventory)
		{
			var inventroy_slot_check_collision_list = ds_list_create();
			instance_place_list(x,y,obj_item_in_inventory,inventroy_slot_check_collision_list,true);
			item_to_swap_with = ds_list_find_value(inventroy_slot_check_collision_list,0);
			what_slot = instance_place(obj_player.starting_inventory_x + item_to_swap_with.slot_placement_x, obj_player.starting_inventory_y + item_to_swap_with.slot_placement_y,obj_check_inventory_slot);
			item_in_hand_slot = instance_place(obj_player.starting_inventory_x + slot_placement_x, obj_player.starting_inventory_y + slot_placement_y,obj_check_inventory_slot);
			
			//check to see if the item CAN be swapped to that inventory slot
			if my_item_class == item_to_swap_with.my_item_class or what_slot.my_slot_class == item_in_hand_slot.my_slot_class
			{		
				
				var olde_slot_placement_x = slot_placement_x;
				var olde_slot_placement_y = slot_placement_y;
				var olde_inventory_slot = current_inventory_slot;
				//current_inventory_slot
			
				ds_list_replace(obj_player.inventory_list,current_inventory_slot,item_to_swap_with.my_item_number);
				ds_list_replace(obj_player.inventory_list,item_to_swap_with.current_inventory_slot,my_item_number);
			
				slot_placement_x = item_to_swap_with.slot_placement_x;
				slot_placement_y = item_to_swap_with.slot_placement_y;
				current_inventory_slot = item_to_swap_with.current_inventory_slot;
			
				x = obj_player.starting_inventory_x + slot_placement_x;
				y = obj_player.starting_inventory_y + slot_placement_y;
			
			
			
				with(item_to_swap_with)
				{
					slot_placement_x = olde_slot_placement_x;
					slot_placement_y = olde_slot_placement_y;
					current_inventory_slot = olde_inventory_slot;
				
					x = obj_player.starting_inventory_x + slot_placement_x;
					y = obj_player.starting_inventory_y + slot_placement_y;
				}
			
			
			}
			else
			{
				//not placed on another item nor on a valid inventory slot...so just go back to where your old slot was
				x = obj_player.starting_inventory_x + slot_placement_x;
				y = obj_player.starting_inventory_y + slot_placement_y;
			}
			
			
		}
		else
		{
			//place in empty inv slot
			if place_meeting(x,y,obj_check_inventory_slot)
			{
				what_slot = instance_place(x,y,obj_check_inventory_slot);
							
				if what_slot.my_slot_class == my_item_class or what_slot.my_slot_class == ITEM_CLASS.ANYTHING
				{
					var new_slot = instance_nearest(x,y,obj_check_inventory_slot);
					slot_placement_x = new_slot.slot_placement_x;
					slot_placement_y = new_slot.slot_placement_y;
				
					x = obj_player.starting_inventory_x + slot_placement_x;
					y = obj_player.starting_inventory_y + slot_placement_y;
				
				
					ds_list_replace(obj_player.inventory_list,current_inventory_slot,-1);
					current_inventory_slot = new_slot.current_inventory_slot;
					ds_list_replace(obj_player.inventory_list,current_inventory_slot,my_item_number);
				}
				else
				{
					//not placed on another item nor on a valid inventory slot...so just go back to where your old slot was
					x = obj_player.starting_inventory_x + slot_placement_x;
					y = obj_player.starting_inventory_y + slot_placement_y;
				}
			}
			else
			{
				if place_meeting(x,y,obj_inventory_bag_collision)
				{
					//not placed on another item nor on a valid inventory slot...so just go back to where your old slot was
					x = obj_player.starting_inventory_x + slot_placement_x;
					y = obj_player.starting_inventory_y + slot_placement_y;
				}
				else
				{
					//we are now dropping the item OUTSIDE our bag
					with (instance_create_depth(obj_player.x,obj_player.y,DEPTH.ITEM_ON_FLOOR,obj_item_on_floor))
					{
						sprite_index = other.sprite_index;
						image_index = other.image_index;
						my_item_number = other.my_item_number;
						my_item_class = other.my_item_class;
					}
					
					
					//remove ourself from the inventory
					ds_list_replace(obj_player.inventory_list,current_inventory_slot,-1);
					
					//destroy ourself
					instance_destroy();
					
				}
				
				
			}
		}
	}
	
	
	//empty our hand
	item_in_hand = -1;
	
	sprite_index = spr_cursor;
	mask_index = spr_cursor;
}





//move the item with us if we have one in our hand
if item_in_hand != -1
{
	with (item_in_hand)
	{
		x = other.x;
		y = other.y;
	}
}



//assuming we are looking at nodes
if mouse_check_button(mb_middle)
{
	
	var change_in_mouse_x = mouse_x - olde_mouse_x;
	var change_in_mouse_y = mouse_y - olde_mouse_y;
	
		
	if instance_exists(obj_node)
	{
		with(obj_node)
		{
			x += change_in_mouse_x;
			y += change_in_mouse_y;
		}
	}
	
	
}





//update olde mouse positions
olde_mouse_x = mouse_x;
olde_mouse_y = mouse_y;






