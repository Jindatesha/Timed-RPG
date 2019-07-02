/// @description Insert description here
// You can write your code in this editor




//if the player is colliding with us(in our zone) AND presses the active button
if place_meeting(x,y,obj_player) and keyboard_check_pressed(ord("E"))
{
	if !instance_exists(obj_forge_menu)
	{
		
		
		//create the menu
		instance_create_depth(view_x + ((view_w - sprite_get_width(spr_ui_forge_backing))/2),view_y + ((view_h - sprite_get_height(spr_ui_forge_backing))/2),DEPTH.BELOW_CURSOR,obj_forge_menu);

		
		
		//freeze the players movement, attacks and camera...
		global.freeze_character = true;
		global.can_move_towards_mouse = false;

	
		//make players weapon invisible
		obj_player.my_weapon.visible = false;


	
	}
	else
	{
		//allow the player and camera to move again 
		global.freeze_character = false;
		global.can_move_towards_mouse = true;

	
		//make players weapon visible
		obj_player.my_weapon.visible = true;


		//close the menu
		with(obj_forge_menu)
		{
			surface_free(sheets_surface);
			instance_destroy();
		}
		
	}
	

	
	
	
}














