/// @description This script allows us to have a single line for adding all our grids variables for a single item
//item# = height

/// @param sprite_index
/// @param image_index
/// @param item_class
/*
dmg
atk speed,
weight = affects atk speed and movement speed while weilding this
etc...
*/


var i = 0;
var number_of_variables_these_items_have = 3;

//add +1 to our row
ds_grid_resize(global.item_database_grid,ds_grid_width(global.item_database_grid),ds_grid_height(global.item_database_grid) + 1);

repeat(number_of_variables_these_items_have)
{
	ds_grid_add(global.item_database_grid,i,ds_grid_height(global.item_database_grid) - 1,argument[i]);
	i += 1;
}








