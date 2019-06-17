/// @description Insert description here
// You can write your code in this editor


for(var n = 0; n < ds_grid_height(global.node_grid); n += 1;)
{
	with(instance_find(obj_node,n))
	{				
		activated = ds_list_find_value(other.changed_nodes_unlocked_list,n);
	}
}


