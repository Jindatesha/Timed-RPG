/// @description Insert description here
// You can write your code in this editor




//draw hud
var bottom_hud_spacer = 40;
var hud_starting_x = (view_w/2) - (sprite_get_width(spr_hud)/2);
var hud_starting_y = view_h - sprite_get_height(spr_hud) - bottom_hud_spacer;

draw_sprite(spr_hud,0,hud_starting_x,hud_starting_y);






#region draw_health bar
var starting_health_bar_x = hud_starting_x + 5;
var starting_health_bar_y = hud_starting_y + 142;


show_health_reduction_timer -= 1;

if show_health_reduction_timer > 0
{
	//draw health lossed amount
	draw_sprite_part(spr_ui_player_lossed_health_bar,0,0,0,(sprite_get_width(spr_ui_player_lossed_health_bar) * (hp_lossed/my_max_hp)) * (show_health_reduction_timer/show_health_max_reduction_time),sprite_get_height(spr_ui_player_lossed_health_bar),starting_health_bar_x + (sprite_get_width(spr_ui_player_lossed_health_bar) * (my_hp/my_max_hp)),starting_health_bar_y);
}



//draw health bar
draw_sprite_part(spr_ui_player_health_bar,0,0,0, sprite_get_width(spr_ui_player_health_bar) * (my_hp/my_max_hp),sprite_get_height(spr_ui_player_health_bar),starting_health_bar_x,starting_health_bar_y);

//draw health bar numbers
//draw exp bar numbers
draw_set_font(font_small_hud_bars);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(round(starting_health_bar_x + (sprite_get_width(spr_ui_player_health_bar)/2)),round(starting_health_bar_y + (sprite_get_height(spr_ui_player_health_bar)/2)),string(my_hp) + "/" + string(my_max_hp));
#endregion	
	
	
	
#region Exp Bar
var starting_exp_bar_x = starting_health_bar_x;
var starting_exp_bar_y = starting_health_bar_y + 48;

//draw exp bar
draw_sprite_part(spr_ui_player_exp_bar,0,0,0, sprite_get_width(spr_ui_player_exp_bar) * (my_current_exp/my_total_exp_required_till_next_level),sprite_get_height(spr_ui_player_exp_bar),starting_exp_bar_x,starting_exp_bar_y);

//draw exp bar numbers
draw_set_font(font_small_hud_bars);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(round(starting_exp_bar_x + (sprite_get_width(spr_ui_player_exp_bar)/2)),round(starting_exp_bar_y + (sprite_get_height(spr_ui_player_exp_bar)/2)),string(my_current_exp) + "/" + string(my_total_exp_required_till_next_level));



#endregion
	
	




