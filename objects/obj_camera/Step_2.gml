


var x_to,y_to;

//if we can move in the direction of the mouse
if global.can_move_towards_mouse == true
{
	//change our direction towards mouse
	move_towards_point(mouse_x,mouse_y,0);
	x_to = obj_player.x + lengthdir_x(min(96,distance_to_point(mouse_x,mouse_y)),direction);
	y_to = obj_player.y + lengthdir_y(min(96,distance_to_point(mouse_x,mouse_y)),direction);
}
else
{
	x_to = x;
	y_to = y;
}


x += round((x_to - x));
y += round((y_to - y));

//so that way the camera doesnt leave outside the room
//var locked_x = round(clamp(x - (view_w/2),0,room_width - view_w));
//var locked_y = round(clamp(y - (view_h/2),0,room_height - view_h));

var locked_x = round(x - (view_w/2));
var locked_y = round(y - (view_h/2));

camera_set_view_size(view,global.width,global.height);

camera_set_view_pos(view,locked_x,locked_y);






#region if player attacked...screenshake
if global.player_has_attacked == true
{
	has_set_original_view_before_screenshake = true;
	var screenshake_amount = random_range(-12,12);
	
	original_view_before_screenshake_x += lengthdir_x(screenshake_amount,obj_player.mouse_dir);
	original_view_before_screenshake_y += lengthdir_y(screenshake_amount,obj_player.mouse_dir);
	
	camera_set_view_pos(view,view_x + lengthdir_x(screenshake_amount,obj_player.mouse_dir),view_y + lengthdir_y(screenshake_amount,obj_player.mouse_dir));
}
else
{	
	if has_set_original_view_before_screenshake == true
	{
		has_set_original_view_before_screenshake = false;
		camera_set_view_pos(view,view_x + original_view_before_screenshake_x,view_y + original_view_before_screenshake_y);
		original_view_before_screenshake_x = 0;
		original_view_before_screenshake_y = 0;
	}
}
#endregion











