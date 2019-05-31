

//draw the textured background*
var starting_x = view_x;
var starting_y = view_y;
var camera_width = view_w;
var camera_height = view_h;
draw_sprite_stretched(spr_background_level_up,0,starting_x,starting_y,camera_width,camera_height);




var top_buffer = 70;//px

//draw the spec points ui
draw_sprite(spr_level_node_hud_points,0,starting_x + camera_width/2,starting_y + top_buffer);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//draw on top of the spec points ui, the amount of spec points the player has
draw_text(starting_x + camera_width/2,starting_y + top_buffer + (sprite_get_height(spr_level_node_hud_points) * 0.3) ,string(changed_spec_points));

//"points"
draw_text(starting_x + camera_width/2,starting_y + top_buffer + (sprite_get_height(spr_level_node_hud_points)/2) + (string_height(changed_spec_points)/3) + 2,"Points");

var button_x = starting_x + camera_width/2;
var button_y = starting_y + (top_buffer * 2) + (sprite_get_height(spr_level_node_hud_points)/2) + (string_height(changed_spec_points)/3) + 2;

var button_separator = (sprite_get_width(spr_level_node_hud_buttons)/5);

var point_ui_padding = 8;

//button for confirm 
draw_sprite(spr_level_node_hud_buttons,0,button_x - (sprite_get_width(spr_level_node_hud_buttons)/2) - (button_separator/2),button_y + point_ui_padding);
draw_text(button_x - (sprite_get_width(spr_level_node_hud_buttons)/2) - (button_separator/2),button_y + point_ui_padding + (sprite_get_height(spr_level_node_hud_buttons)/2),"CONFIRM");


//button for cancel
draw_sprite(spr_level_node_hud_buttons,0,button_x + (sprite_get_width(spr_level_node_hud_buttons)/2) + (button_separator/2),button_y + point_ui_padding);
draw_text(button_x + (sprite_get_width(spr_level_node_hud_buttons)/2) + (button_separator/2),button_y + point_ui_padding + (sprite_get_height(spr_level_node_hud_buttons)/2),"RESET");





//if mouse is in our confirm button and pressed
if mouse_check_button_pressed(mb_left)
{
	if point_in_rectangle(mouse_x,mouse_y,button_x - (sprite_get_width(spr_level_node_hud_buttons)) - (button_separator/2),button_y + point_ui_padding,button_x - (button_separator/2),button_y + point_ui_padding + (sprite_get_height(spr_level_node_hud_buttons)))
	{
		
		//instance_activate_all();
		//instance_destroy(obj_node);
		
		//make sure to save the players spec points by changing them into what our new-ended pool amount was 
		instance_activate_object(current_player);
		with(current_player)
		{
			my_spec_points = other.changed_spec_points;
			ds_list_copy(nodes_unlocked_list,other.changed_nodes_unlocked_list);
			
			//recalculate our stats
			event_user(0);
		}
		instance_deactivate_object(current_player);
		
		//ds_list_destroy(changed_nodes_unlocked_list);
		//instance_destroy();
	}
}





//if mouse is in our reset button and pressed
if mouse_check_button_pressed(mb_left)
{
	if point_in_rectangle(mouse_x,mouse_y,button_x + (button_separator/2),button_y + point_ui_padding,button_x + (button_separator/2) + (sprite_get_width(spr_level_node_hud_buttons)),button_y + point_ui_padding + (sprite_get_height(spr_level_node_hud_buttons)))
	{		
		
		//reset the pool to however many it was initially and resetting the nodes that were changed, back to not activated 
		for(var n = 0; n < ds_grid_height(global.node_grid); n += 1;)
		{
			with(instance_find(obj_node,n))
			{
				
				if was_changed_this_turn == true
				{
					was_changed_this_turn = false;					
					activated = false;
					
					//update list pool
					ds_list_replace(other.changed_nodes_unlocked_list,n,0);
					other.changed_spec_points += 1;
				}
				
			}
		}
	}
}











//hitting escape cancels and gets out of this menu
if keyboard_check_pressed(vk_escape)
{
		instance_activate_all();
		instance_destroy(obj_node);
		
		ds_list_destroy(changed_nodes_unlocked_list);
		instance_destroy();
}


