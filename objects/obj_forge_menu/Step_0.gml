/// @description Insert description here
// You can write your code in this editor





//create the forge tabs
var tab_height = sprite_get_height(spr_ui_forge_tabs);
var tab_width = sprite_get_width(spr_ui_forge_tabs);
var tab_spacer = 20;
var this_is_the_selected_tab = 0;
var this_tabs_x = 0;
var this_tabs_y = 0;

//reset hovered tab to see which tab we might be hovering over
hovered_tab = -1;


//for all the tabs
for(var i = 0; i < 7; i += 1)
{
	//this tabs location
	this_tabs_x = x + 43 + (i * (tab_width + tab_spacer)) + (tab_width/2);
	this_tabs_y = y + 14 + (tab_height/2);
	
	
	//which tab are we hovered over?
	if mouse_x <= this_tabs_x + ((tab_width + tab_spacer)/2) and mouse_x >= this_tabs_x - ((tab_width + tab_spacer)/2) and mouse_y < this_tabs_y + (tab_height/2) and mouse_y > this_tabs_y - (tab_height/2)
	{
		hovered_tab = i;
		
		//change our selected tab if we pressed this tab
		if mouse_check_button_pressed(mb_left)
		{
			selected_tab = i;
			
			
			
		}		
	}
}



//if no tabs were hovered over...then make the "hovered version" our selected tab
if hovered_tab == -1
{
	hovered_tab = selected_tab;
}





var scroll_increment = 60;


if mouse_wheel_up()
{
	scroll_amount += scroll_increment;
}



if mouse_wheel_down()
{
	scroll_amount -= scroll_increment;
}



//cap the scroll so u dont go beyond all the item_sheets in either up or down
scroll_amount = clamp(scroll_amount,-1 * ((how_many_total_items_in_this_item_type_array[selected_tab] * sprite_get_height(spr_ui_forge_crafting_sheet)) - surface_get_height(sheets_surface)),0);













