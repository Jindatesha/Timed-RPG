/// @description Insert description here
// You can write your code in this editor


//draw message backing
draw_self();




//draw options
var option_placement_x = x + 84;
var option_placement_y = y + 20;


draw_set_font(font_inn);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


var hovered_move_amount = 20;

var inn_option_width = sprite_get_width(spr_ui_inn_option_backing);
var inn_option_height = sprite_get_height(spr_ui_inn_option_backing);
var arrow_move_amount = 30;
var arrow_move_speed = 0.1;

my_arrow_angle += arrow_move_speed;

for( i = 0; i < 2; i += 1;)
{
	var this_option = "YES";
	if i == 1 this_option = "NO";
	
	
	//which one are we hovering over?
	if mouse_x > option_placement_x and mouse_x < option_placement_x + inn_option_width and mouse_y > option_placement_y + (inn_option_height * i) and mouse_y < option_placement_y + (inn_option_height * (i+1))
	{
		if hovered_option != i
		{
			hovered_option = i;
			my_arrow_angle = 180;
		}
		
		
		if mouse_check_button_pressed(mb_left)
		{
			button_select_pushed = 1;
		}
		
		
	}
	
	
	if hovered_option == i
	{
		draw_sprite(spr_ui_inn_option_backing,0,option_placement_x + hovered_move_amount,option_placement_y + (inn_option_height * i));
		draw_text(option_placement_x + hovered_move_amount + (inn_option_width/2),option_placement_y + (inn_option_height/2) + (inn_option_height * i),string(this_option));
		draw_sprite(spr_ui_dialogue_arrow,0,option_placement_x + (((cos(my_arrow_angle) + 1)/2) * arrow_move_amount), option_placement_y + (inn_option_height/2) + (inn_option_height * i));
	}
	else
	{
		draw_sprite(spr_ui_inn_option_backing,0,option_placement_x,option_placement_y + (inn_option_height * i));
		draw_text(option_placement_x + (inn_option_width/2),option_placement_y + (inn_option_height/2) + (inn_option_height * i),string(this_option));
	}
	
}



if button_select_pushed > 0
{
	switch(hovered_option)
	{
		case 0:
		//"YES"
			
			//allow the player to move again
			if instance_exists(obj_player)
			{
				
				if has_started_to_fade == false
				{
					has_started_to_fade = true;
					
					//get the players hp and max hp
					at_time_players_max_hp = obj_player.my_max_hp;
					at_time_players_current_hp = obj_player.my_hp
					
					alarm[0] = max_fade_in_time;
					alarm[1] = max_fade_in_time + max_fade_out_time;
					
				}
				
				
				
			}
			
		
			
		
		break;
		
		case 1:
		//"NO"
			//allow the player to move again
			if instance_exists(obj_player)
			{
				with (obj_player)
				{
					my_weapons[current_weapon].visible = true;
					can_switch_state = true;
					current_state = STATE.WALK;
					global.freeze_character = false;
					global.can_move_towards_mouse = true;
					
					//move the player downwards
					y += 130;
				
				}
				
			}
			
		
			//destroy ourself
			instance_destroy();
		
		break;
	}
}


if has_started_to_fade == true
{
	
	if instance_exists(obj_player)
	{
		obj_player.my_hp += ((at_time_players_max_hp - at_time_players_current_hp)/max_fade_in_time);
		obj_player.my_hp = clamp(obj_player.my_hp,0,obj_player.my_max_hp);
	}
	
	scr_fade_black(fade_version,fade_time);
	
}	
	