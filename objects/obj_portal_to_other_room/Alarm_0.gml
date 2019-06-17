

with (obj_camera)
{

x = obj_player.x;
y = obj_player.y;

var locked_x = round(x - (view_w/2));
var locked_y = round(y - (view_h/2));

camera_set_view_pos(view,locked_x,locked_y);


}


obj_player.x = player_new_x;
obj_player.y = player_new_y;
	




//before going to next room...lets add all the enemies to our spawners room_list
var how_many_enemies_are_active_in_room = instance_number(obj_enemy);
var current_monster = 0;
repeat(how_many_enemies_are_active_in_room)
{
	var this_monster = instance_find(obj_enemy,current_monster); 
	
	with(obj_enemy_spawner)
	{
		ds_list_add(enemy_spawn_room_list[current_room_number],this_monster.object_index);
	
	}
	
	
	current_monster += 1;
}
	
room_goto(my_room);
	
	
	
	
	
	