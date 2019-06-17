/// @description Insert description here
// You can write your code in this editor


draw_self();


//create the forge tabs
var tab_height = sprite_get_height(spr_ui_forge_tabs);
var tab_width = sprite_get_width(spr_ui_forge_tabs);
var tab_spacer = 20;
var this_is_the_selected_tab = 0;
var this_tabs_x = 0;
var this_tabs_y = 0;


//for all the tabs
for(var i = 0; i < 7; i += 1)
{
	//this tabs location
	this_tabs_x = x + 43 + (i * (tab_width + tab_spacer)) + (tab_width/2);
	this_tabs_y = y + 14 + (tab_height/2);
	
	
	
	//which one is the hovered tab?
	if i == hovered_tab
	{
		this_is_the_selected_tab = 1;
	}
	else
	{
		this_is_the_selected_tab = 0;
	}
	
	
	//draw the tabs
	draw_sprite(spr_ui_forge_tabs,(i * 2) + this_is_the_selected_tab,this_tabs_x,this_tabs_y);



}



surface_set_target(sheets_surface);
draw_clear_alpha(c_black, 0);
//for the selected tab (lets draw all the item sheets)
for(var i = 0; i < how_many_total_items_in_this_item_type_array[selected_tab]; i += 1;)
{
	
	var this_sheets_x = 0;
	var this_sheets_y = (sprite_get_height(spr_ui_forge_crafting_sheet) * i) + scroll_amount;
	draw_sprite(spr_ui_forge_crafting_sheet, i mod 2,this_sheets_x,this_sheets_y);
	
	
	//access all of our information for the item crafting grid 
	
	
	//our items image for what this sheet can create
	var this_items_item_number = ds_grid_get(global.item_forge_grid,0,i + starting_list_number_array[selected_tab]);
	
	var this_items_sprite_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.SPRITE_INDEX,this_items_item_number);
	var this_items_image_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.IMAGE_INDEX,this_items_item_number) - starting_list_number_array[selected_tab];
	
	//image of the item we can create
	draw_sprite(this_items_sprite_index,this_items_image_index,this_sheets_x + 1030,this_sheets_y + 135);
	
	
	
	


	
	//description of the item in the sheet
	var this_items_description = ds_grid_get(global.item_forge_grid,1,i + starting_list_number_array[selected_tab]);
	
	draw_set_font(font_forge);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_ext(this_sheets_x + 50,this_sheets_y + 50,string(this_items_description),string_height("Z"),350);
	
	
	var material_number = 2;
	
	//for the forge button...later
	var can_we_forge_this_item = 1;//0 = no and 1 == yes
	
	//draw all the materials in their respective recipe block
	repeat(6)
	{
		var this_items_material_item_number = ds_grid_get(global.item_forge_grid,material_number,i + starting_list_number_array[selected_tab]);
		var this_materials_count = ds_grid_get(global.item_forge_grid,material_number + 1,i + starting_list_number_array[selected_tab]);
		
		if this_items_material_item_number != -1
		{
			
			
			var this_materials_pos_x = this_sheets_x + 540 + (120 * (((material_number/2) - 1) mod 3));
			var this_materials_pos_y = this_sheets_y + 150 + (120 * (((material_number/2) - 1) div 3))
			
			draw_sprite(spr_all_materials,this_items_material_item_number,this_materials_pos_x,this_materials_pos_y);
		
	
		
			//organize all of our materials in our inventory!
			var players_bag_size = 9;
			var bag_slot_number = 0;
			var in_bag_this_material_count = 0;
			
			repeat(players_bag_size)
			{
				if ds_list_find_value(obj_player.inventory_list,8 + bag_slot_number) == this_items_material_item_number
				{
					in_bag_this_material_count += 1;
				}
			
				bag_slot_number += 1;
			}
			
			
			//draw material count on bottom right of this material
			var this_materials_text_color = c_white;
			
			if this_materials_count > in_bag_this_material_count
			{
				this_materials_text_color = c_red;
				can_we_forge_this_item = 0;
			}
			
			
			draw_set_valign(fa_middle);
			draw_text_color(this_materials_pos_x + 35,this_materials_pos_y + 45, string(this_materials_count),this_materials_text_color,this_materials_text_color,this_materials_text_color,this_materials_text_color,1);
			
			
		}
		
		
		 
		material_number += 2;
	}
	
	
	
	// this is where to be drawn on the surface
	var this_forge_buttons_x_on_surface = this_sheets_x + 930;
	var this_forge_buttons_y_on_surface = this_sheets_y + 300;
	var stating_loc_for_sheets = 167;
	var this_forge_buttons_x = x + this_sheets_x + 930;
	var this_forge_buttons_y = y + this_sheets_y + stating_loc_for_sheets + 300;
	draw_sprite(spr_ui_forge_button,can_we_forge_this_item,this_forge_buttons_x_on_surface,this_forge_buttons_y_on_surface);
	
	if can_we_forge_this_item == 1
	{
		//did we click inside the forge button?
		if mouse_check_button_pressed(mb_left)
		{
			if mouse_x >= this_forge_buttons_x  and mouse_x <= this_forge_buttons_x + sprite_get_width(spr_ui_forge_button) and mouse_y >= this_forge_buttons_y and mouse_y <= this_forge_buttons_y + sprite_get_height(spr_ui_forge_button)
			{
			
				
				
				//get rid of all the materials in our inventory that are required by the item we are wanting the blacksmith to make
				var material_number = 2;
				repeat(6)
				{
					var this_items_material_item_number = ds_grid_get(global.item_forge_grid,material_number,i + starting_list_number_array[selected_tab]);
					var this_materials_count = ds_grid_get(global.item_forge_grid,material_number + 1,i + starting_list_number_array[selected_tab]);
		
					if this_items_material_item_number != -1
					{
		
						//organize all of our materials in our inventory!
						var players_bag_size = 9;
						var bag_slot_number = 0;
			
						repeat(players_bag_size)
						{
							if this_materials_count > 0
							{
								if ds_list_find_value(obj_player.inventory_list,8 + bag_slot_number) == this_items_material_item_number
								{
									//subtract the count
									this_materials_count -= 1;
							
									//remove this item from our inventory
									ds_list_replace(obj_player.inventory_list,8 + bag_slot_number,-1);
								}
							}
							else
							{
								break;
							}
							
							bag_slot_number += 1;
						
						}
				
					}
					
					material_number += 2;
				}
				
				
				
				//now that we removed all the necessary materials to forge our item...put it in the players inventory
				var bag_slot_number = 0;
				repeat(players_bag_size)
				{
					if ds_list_find_value(obj_player.inventory_list,8 + bag_slot_number) == -1
					{
						ds_list_replace(obj_player.inventory_list,8 + bag_slot_number,this_items_item_number);
						break;
					}
					
					bag_slot_number += 1;
				}
				
				
			}	
				
		}
	}
	

}

surface_reset_target();
draw_surface(sheets_surface,x,y + 167);








