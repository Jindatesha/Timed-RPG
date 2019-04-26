/// @description Insert description here
// You can write your code in this editor

//controls
var move_left = keyboard_check(ord("A"));
var move_right = keyboard_check(ord("D"));
var move_up = keyboard_check(ord("W"));
var move_down = keyboard_check(ord("S"));

if can_control_player == true
{
	var h_speed = (move_right - move_left) * move_speed;
	var v_speed = (move_down - move_up) * move_speed;
	
	olde_h_speed = h_speed;
	olde_v_speed = v_speed;
}
else
{
	//like dodgerolling
	var h_speed = olde_h_speed * dodge_roll_speed; 
	var v_speed = olde_v_speed * dodge_roll_speed;
}

var dodge_roll = mouse_check_button_pressed(mb_right);


#region statemachine~ normal movement
if can_switch_state == true
{
	 //what state am I in?
	mouse_dir = point_direction(x,y,mouse_x,mouse_y);


	if (mouse_dir >= 0 and mouse_dir < 22)  my_state = player_state[PLAYER_STATE.RIGHT]; 	
	if (mouse_dir >= 337 and mouse_dir <= 360)  my_state = player_state[PLAYER_STATE.RIGHT]; 	
	if mouse_dir >= 22 and mouse_dir < 67 my_state = player_state[PLAYER_STATE.DIAG_UP_RIGHT];
	if mouse_dir >= 67 and mouse_dir < 112 my_state = player_state[PLAYER_STATE.UP];
	if mouse_dir >= 112 and mouse_dir < 157 my_state = player_state[PLAYER_STATE.DIAG_UP_LEFT];
	if mouse_dir >= 157 and mouse_dir < 202 my_state = player_state[PLAYER_STATE.LEFT];
	if mouse_dir >= 202 and mouse_dir < 247 my_state = player_state[PLAYER_STATE.DIAG_DOWN_LEFT];
	if mouse_dir >= 247 and mouse_dir < 292 my_state = player_state[PLAYER_STATE.DOWN];
	if mouse_dir >= 292 and mouse_dir < 337 my_state = player_state[PLAYER_STATE.DIAG_DOWN_RIGHT];

}
#endregion



#region dodgeroll
if can_switch_state == true and dodge_roll > 0
{
	dodge_roll_dir = point_direction(x,y,x + h_speed, y + v_speed);


	if (dodge_roll_dir >= 0 and dodge_roll_dir < 22)  
	{	
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_RIGHT];
		can_switch_state = false;
		can_control_player = false;		
	}
	
	
	if (dodge_roll_dir >= 337 and dodge_roll_dir <= 360)  
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_RIGHT];
		can_switch_state = false;
		can_control_player = false;		
	}


	if dodge_roll_dir >= 22 and dodge_roll_dir < 67 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_DIAG_UP_RIGHT];
		can_switch_state = false;
		can_control_player = false;		
	}


	if dodge_roll_dir >= 67 and dodge_roll_dir < 112 
	{
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_UP];
		can_switch_state = false;
		can_control_player = false;		
	}

	if dodge_roll_dir >= 112 and dodge_roll_dir < 157 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_DIAG_UP_LEFT];
		can_switch_state = false;
		can_control_player = false;			
	}


	if dodge_roll_dir >= 157 and dodge_roll_dir < 202 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_LEFT];
		can_switch_state = false;
		can_control_player = false;			
	} 
	
	
	if dodge_roll_dir >= 202 and dodge_roll_dir < 247 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_DIAG_DOWN_LEFT];
		can_switch_state = false;
		can_control_player = false;			
	}
	
	
	if dodge_roll_dir >= 247 and dodge_roll_dir < 292 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_DOWN];
		can_switch_state = false;
		can_control_player = false;			
	}
	
	
	if dodge_roll_dir >= 292 and dodge_roll_dir < 337 
	{		
		my_state = player_state[PLAYER_STATE.DODGE_ROLL_DIAG_DOWN_RIGHT];
		can_switch_state = false;
		can_control_player = false;			
	}
	
	
	image_index = 0;
	alarm[0] = round((sprite_get_number(my_state)) * 4);
}

#endregion




#region horizontal/vertical movement & collision

//horizontal
if place_meeting(x + h_speed, y,obj_solid)
{
	while !place_meeting(x + sign(h_speed), y,obj_solid)
	{
		x += sign(h_speed);			
	}
	
	h_speed = 0;
}
else
{
	x += h_speed;	
}



//vertical movement
if place_meeting(x, y + v_speed,obj_solid)
{
	while !place_meeting(x, y + sign(v_speed),obj_solid)
	{
		y += sign(v_speed);
	}
	
	v_speed = 0;
}
else
{
	y += v_speed;
}


#endregion







//finally set our sprites image
sprite_index = my_state;


