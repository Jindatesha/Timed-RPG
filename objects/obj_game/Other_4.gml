/// @description Insert description here
// You can write your code in this editor


has_started_fading = true;
obj_player.can_switch_state = false;
obj_player.current_state = STATE.WALK; 
alarm[0] = fade_in_max_time;




//move all objects and tiles and EVERYTHING over...
/*
with(all)
{
	x += view_w/2;
	y += view_h/2;

}



//move all tiles as well
tilemap_x(layer_tilemap_get_id(layer_get_id("tile_above_player")),view_w/2);
tilemap_y(layer_tilemap_get_id(layer_get_id("tile_above_player")),view_h/2);

tilemap_x(layer_tilemap_get_id(layer_get_id("tile_below_player_above_floor")),view_w/2);
tilemap_y(layer_tilemap_get_id(layer_get_id("tile_below_player_above_floor")),view_h/2);

tilemap_x(layer_tilemap_get_id(layer_get_id("tile_floor")),view_w/2);
tilemap_y(layer_tilemap_get_id(layer_get_id("tile_floor")),view_h/2);