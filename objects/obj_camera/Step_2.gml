


var x_to,y_to;
move_towards_point(mouse_x,mouse_y,0);
x_to = obj_player.x + lengthdir_x(min(96,distance_to_point(mouse_x,mouse_y)),direction);
y_to = obj_player.y + lengthdir_y(min(96,distance_to_point(mouse_x,mouse_y)),direction);

x += round((x_to - x));
y += round((y_to - y));

//so that way the camera doesnt leave outside the room
var locked_x = round(clamp(x - (view_w/2),0,room_width - view_w));
var locked_y = round(clamp(y - (view_h/2),0,room_height - view_h));


camera_set_view_pos(view,locked_x,locked_y);





/*
//what am I following?
camera_following = obj_player;

//follow that around
if instance_exists(camera_following)
{
	//so that way the camera doesnt leave outside the room
	var locked_x = round(clamp(camera_following.x - (view_w/2),0,room_width - view_w));
	var locked_y = round(clamp(camera_following.y - (view_h/2),0,room_height - view_h));
	
	camera_set_view_size(view,960,540);
	camera_set_view_pos(view,locked_x,locked_y);
}










