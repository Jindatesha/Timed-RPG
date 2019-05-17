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




//for the selected tab (lets draw all the item sheets)
for(var i = 0; i < what_item_list_to_use_array[selected_tab]; i += 1;)
{
	surface_set_target(sheets_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(spr_ui_forge_crafting_sheet, i mod 2,0,(sprite_get_height(spr_ui_forge_crafting_sheet) * i) + scroll_amount);
	
	surface_reset_target();
	draw_surface(sheets_surface,x,y + 167);
}










