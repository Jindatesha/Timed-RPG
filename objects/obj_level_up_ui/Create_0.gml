/// @description Insert description here
// You can write your code in this editor



/// @description Insert description here
// You can write your code in this editor

players_needing_to_place_nodes = global.how_many_active_players;

current_player = instance_find(obj_player,0);

changed_spec_points = 0;


//reduce depth so its on top of everything
depth = DEPTH.SMALLEST - 1;

//deactivate all objects so nothing moves while in menus
instance_deactivate_all(true);

//but keep these active:
instance_activate_object(obj_game);
instance_activate_object(obj_cursor);

var starting_x = view_x + (view_w/2);
var starting_y = view_y + (view_h/2);



//place all of our nodes
for(var i = 0; i < ds_grid_height(global.node_grid); i += 1;)
{
	with(instance_create_layer(x,y,0,obj_node))
	{
		
		//initializing base variables
		x = ds_grid_get(global.node_grid,0,i);
		y = ds_grid_get(global.node_grid,1,i);
		
		x += starting_x;
		y += starting_y;		
		
		my_node_type = ds_grid_get(global.node_grid,2,i);
		this_nodes_thread_list = ds_list_create();
		my_node_number = i;
		activated = ds_grid_get(global.node_grid,3,i);
		depth = other.depth - (1 + i);		
		was_changed_this_turn = false;
		image_speed = 0;
		
		image_index = my_node_type;
		
		
		if my_node_type > NODE_TYPE.HEALTH
		{
			sprite_index = spr_level_node_special;
			//which image index  = my node type - 3
		}
		
		
		//add the first sigfig to our list
		ds_list_add(this_nodes_thread_list,floor(ds_grid_get(global.node_grid,4,i)));
		
		
		
		//is there any decimals?
		var our_number = frac(ds_grid_get(global.node_grid,4,i));
		
		looped_times = 0;


		while our_number != 0
		{
			looped_times += 1;
			
			
			our_number = frac(ds_grid_get(global.node_grid,4,i)) *  (power(10,looped_times)) ;
			
			
			our_number = floor(our_number + math_get_epsilon());
			ds_list_add(this_nodes_thread_list,our_number);
			
			our_number = frac(ds_grid_get(global.node_grid,4,i)) * power(10,looped_times);
			our_number = round(our_number);
			our_number = our_number/power(10,looped_times);
			our_number = frac(ds_grid_get(global.node_grid,4,i)) - our_number;			
		}
		

	}
	
	
	
}

























