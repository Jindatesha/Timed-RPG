
//update character stats
var active_nodes_total_gained_hp = 0;


//loop through all nodes and make a list of active ones
var total_nodes = ds_grid_height(global.node_grid);
for (var i = 0; i < total_nodes; i += 1;)
{
	//is it activated?
	if ds_grid_get(global.node_grid,3,i) == true
	{
		var this_node_type = ds_grid_get(global.node_grid,2,i);
		
		switch(this_node_type)
		{
			
			default:
			//do nothing
			break;
			
			case NODE_TYPE.HEALTH:
				active_nodes_total_gained_hp += 100;
			break;
		}
		
	}
	

}



//pull out stats from those
// set stats for player
my_max_hp = starting_hp + active_nodes_total_gained_hp;









