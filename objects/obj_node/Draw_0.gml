/// @description Insert description here
// You can write your code in this editor




for (var i = 0; i < ds_list_size(this_nodes_thread_list); i += 1;)
{
	
	connection = instance_find(obj_node,ds_list_find_value(this_nodes_thread_list,i));
	
	if connection.my_node_number > my_node_number
	{
		//draw_line_width(x,y,connection.x,connection.y,6);
		var rot = point_direction(x,y,connection.x,connection.y);
		
		move_on_x = -(sin(rot) * (sprite_get_height(spr_node_line)/2));
		move_on_y = -(cos(rot) * (sprite_get_height(spr_node_line)/2));
		
		var distance_between_these_nodes = point_distance(x,y,connection.x,connection.y);
		draw_sprite_general(spr_node_line,0,0,0,distance_between_these_nodes,sprite_get_height(spr_node_line),x + lengthdir_y(sprite_get_height(spr_node_line)/2,rot),y - lengthdir_x(sprite_get_height(spr_node_line)/2,rot),1,1,rot,c_white,c_white,c_white,c_white,1);
	
	}
}



draw_self();



draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text(x,y,string(activated));

//debug text to show what node instance # this is 
//draw_text(x,y,string(my_node_number));