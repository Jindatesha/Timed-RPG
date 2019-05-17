

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
	

	
room_goto(my_room);
	
	
	
	
	
	