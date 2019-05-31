/// @description Insert description here
// You can write your code in this editor


draw_self();




var starting_health_bar_x = view_x + 50;
var starting_health_bar_y = view_y + 50;

//draw_health backing
draw_sprite(spr_ui_player_health_backing,0,starting_health_bar_x,starting_health_bar_y);

show_health_reduction_timer -= 1;

if show_health_reduction_timer > 0
{
	//draw health lossed amount
	draw_sprite_part(spr_ui_player_lossed_health_bar,0,0,0,(sprite_get_width(spr_ui_player_lossed_health_bar) * (hp_lossed/my_max_hp)) * (show_health_reduction_timer/show_health_max_reduction_time),sprite_get_height(spr_ui_player_lossed_health_bar),starting_health_bar_x + (sprite_get_width(spr_ui_player_lossed_health_bar) * (my_hp/my_max_hp)),starting_health_bar_y);
}



//draw health bar
draw_sprite_part(spr_ui_player_health_bar,0,0,0, sprite_get_width(spr_ui_player_health_bar) * (my_hp/my_max_hp),sprite_get_height(spr_ui_player_health_bar),starting_health_bar_x,starting_health_bar_y);

	
	
#region Exp Bar

draw_set_font(font_inn);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_text(view_x + 100,view_y + 200,"LVL: " + string(my_level));

#endregion
	
	

#region Inventory

if inventory_on == 1
{
	//draw_inventory
	draw_sprite(spr_inventory_backing,0,starting_inventory_x,starting_inventory_y);

}
#endregion





