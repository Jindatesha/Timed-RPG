/// @description Insert description here
// You can write your code in this editor


enum PLAYER_STATE
{
	LEFT,
	RIGHT,
	UP,
	DOWN,
	DIAG_UP_LEFT,
	DIAG_UP_RIGHT,
	DIAG_DOWN_LEFT,
	DIAG_DOWN_RIGHT,
	DODGE_ROLL_LEFT,
	DODGE_ROLL_RIGHT,
	DODGE_ROLL_UP,
	DODGE_ROLL_DOWN,
	DODGE_ROLL_DIAG_UP_LEFT,
	DODGE_ROLL_DIAG_UP_RIGHT,
	DODGE_ROLL_DIAG_DOWN_LEFT,
	DODGE_ROLL_DIAG_DOWN_RIGHT
		
}


#macro view view_camera[0]
#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)
#macro view_ratio surface_get_width(application_surface)/view_w




enum DEPTH
{
	SMALLEST,
	PLAYER,
	FLOOR
	
}






