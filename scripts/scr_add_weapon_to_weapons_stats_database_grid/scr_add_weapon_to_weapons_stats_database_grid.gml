/// @description This script allows us to have a single line for adding all our grids variables for a single item
//item# = height

/// @param sprite_index
/// @param attack_image_speed
/// @param damage
/// @param collision_sprite_index
/// @param collision_image_number this is what image in the attack animation to spawn the collision check sprite

//stats for this item

/*
dmg
atk speed,
weight = affects atk speed and movement speed while weilding this
etc...
*/


var i = 0;
var number_of_variables_these_items_have = 5;

//add +1 to our row
ds_grid_resize(global.weapons_grid,ds_grid_width(global.weapons_grid),ds_grid_height(global.weapons_grid) + 1);

repeat(number_of_variables_these_items_have)
{
	ds_grid_add(global.weapons_grid,i,ds_grid_height(global.weapons_grid) - 1,argument[i]);
	i += 1;
}








