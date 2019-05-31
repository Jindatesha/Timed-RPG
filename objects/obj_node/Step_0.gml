

//if you click on this node then turn it to active
var current_sprite_width = sprite_get_width(sprite_index)/2;

if mouse_check_button_pressed(mb_left) and  point_in_circle(mouse_x,mouse_y,x,y,current_sprite_width) 
{
	//if the node isnt activated
	if activated == false
	{
		
		var a_tie_is_activated = false;
		//check all of our ties to see if one is actived
		for(var t = 0; t < ds_list_size(this_nodes_thread_list); t += 1;)
		{			
			var this_tie = ds_list_find_value(this_nodes_thread_list,t);
			
			with(instance_find(obj_node,this_tie))
			{
				if activated == true
				{
					a_tie_is_activated = true;
				}
			}
		}
		
		
		//if any of our ties have been activated OR if we are the very first node... then proceed
		if a_tie_is_activated == true or my_node_number == 0
		{
			with(obj_level_up_ui)
			{
				//if the player has points in their pool
				if changed_spec_points > 0
				{
					//take away points from this players pool
					changed_spec_points -= 1;
				
					//update list pool
					ds_list_replace(changed_nodes_unlocked_list,other.my_node_number,1);
				
					//activate the ui's node
					other.activated = true;
				
					//it was activated this turn so...
					other.was_changed_this_turn = true;
				}
			}
		}
		
		
	}
	else
	{
				
		
		//check to see if the node can be deactivated
		if scr_can_we_deactivate_this_node() == true
		{
			//de-activate this node
			activated = false;		
	
			//de-activate...
			was_changed_this_turn = false;
			
			//with our pooled resources from the player:
			with(obj_level_up_ui)
			{
				//put back points to player
				changed_spec_points += 1;
						
				//update list pool
				ds_list_replace(changed_nodes_unlocked_list,other.my_node_number,0);					
			}
		}	
		
	}
}




