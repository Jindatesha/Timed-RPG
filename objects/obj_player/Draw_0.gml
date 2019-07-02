/// @description Insert description here
// You can write your code in this editor


draw_self();





#region Inventory

if inventory_on == 1
{
	//draw_inventory
	draw_sprite(spr_inventory_backing,0,starting_inventory_x,starting_inventory_y);

}
#endregion




#region spell cast
if is_casting_spell[0] or is_casting_spell[1] or is_casting_spell[2]
{
	switch(which_spell)
	{
		case 0:
			//draw the base of the arrow
			var max_distance = sprite_get_width(spr_ability_dash_arrow_tail);
			var distance_to_mouse = point_distance(x,y,mouse_x,mouse_y);
			distance_to_mouse = clamp(distance_to_mouse,0,max_distance);
			var dir_of_mouse = point_direction(x,y,mouse_x,mouse_y);
			
			draw_sprite_ext(spr_ability_dash_arrow_tail,0,x,y,1,1,dir_of_mouse,c_white,1);
			//draw the arrow head
			draw_sprite_ext(spr_ability_dash_arrow_head,0,x + lengthdir_x(length_of_dash,dir_of_mouse),y + lengthdir_y(length_of_dash,dir_of_mouse),1,1,dir_of_mouse,c_white,1);
			
			
			
		break;
		
		//utility item : dummy
		case 1:
		
		break;
		
		
		//utility item: grappling hook
		case 2:
		
		break;
	}
}
#endregion








