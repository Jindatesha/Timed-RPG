/// @description Insert description here
// You can write your code in this editor




//draw hud
var bottom_hud_spacer = 40;
var hud_starting_x = (view_w/2) - (sprite_get_width(spr_hud)/2);
var hud_starting_y = view_h - sprite_get_height(spr_hud) - bottom_hud_spacer;

draw_sprite(spr_hud,0,hud_starting_x,hud_starting_y);






#region draw_health bar
var starting_health_bar_x = hud_starting_x;
var starting_health_bar_y = hud_starting_y;


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
	
	
	
#region ability 0 (weapon special attack)

var ability_0_pos_x = hud_starting_x + 161;
var ability_0_pos_y = hud_starting_y + 77;



cooldown_counter_aray[0] = 1 -  (special_attack_cooldown_timer/max_special_attack_cooldown_time);




//backing
draw_sprite_part_ext(spr_ui_ability_backing,1,0,0,sprite_get_width(spr_ui_ability_backing),sprite_get_height(spr_ui_ability_backing) * cooldown_counter_aray[0],ability_0_pos_x,ability_0_pos_y + sprite_get_height(spr_ui_ability_backing),1,-1,c_white,1);

//ability image

var is_ability_0_on_cooldown = 0;
if special_attack_cooldown_timer > 0
{
	//if the ability is on cd then change to grayscale version
	is_ability_0_on_cooldown = 1;
}


//sprite
var diff = (sprite_get_width(spr_ui_ability_backing) - sprite_get_width(ability_slot[0]))/2;
draw_sprite(ability_slot[0],is_ability_0_on_cooldown,ability_0_pos_x + diff,ability_0_pos_y + diff);


var ability_0_seconds_left = round(special_attack_cooldown_timer/room_speed);
if ability_0_seconds_left == 0
{
	ability_0_seconds_left = round((special_attack_cooldown_timer/room_speed) * 10);
	ability_0_seconds_left = "0." + string(ability_0_seconds_left);
}

var ability_0_text_pos_x = ability_0_pos_x + diff + (sprite_get_width(ability_slot[0])/2);
var ability_0_text_pos_y = ability_0_pos_y + diff + (sprite_get_height(ability_slot[0])/2);

if ability_0_seconds_left != "0.0"
{
	draw_text(ability_0_text_pos_x,ability_0_text_pos_y,string(ability_0_seconds_left));
}
#endregion



