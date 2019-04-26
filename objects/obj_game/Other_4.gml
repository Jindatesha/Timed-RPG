/// @description Insert description here
// You can write your code in this editor

//move all objects and tiles and EVERYTHING over...

with(all)
{
	x += view_w/2;
	y += view_h/2;

}


tilemap_x(layer_tilemap_get_id(layer_get_id("Tiles_1")),view_w/2);
tilemap_y(layer_tilemap_get_id(layer_get_id("Tiles_1")),view_h/2);

