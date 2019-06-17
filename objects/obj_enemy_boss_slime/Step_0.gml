
//since im the boss...
if my_hp <= 0
{
	//if i die...restart the game
	game_restart();
}



//Inherit the parent event
event_inherited();




//if we are within range of the player...
if distance_to_object(obj_player) <= my_range
{
	//start walking over to the player...to attack
	var x_dif = obj_player.x - x;
	var y_dif = obj_player.y - y;
	h_speed = min(abs(x_dif),my_speed) * sign(x_dif);
	v_speed = min(abs(y_dif),my_speed) * sign(y_dif);
	
	
	
	if distance_to_object(obj_player) <= my_attack_range and is_attacking == false
	{
		is_attacking = true;
		time_till_attack = my_attack_wind_up_time;
		can_move = false;
		can_switch_state = false;
		sprite_index = sprite_state_array[STATE.ATTACK_WIND];
		image_index = 0;
		image_speed = 0;
	}
	
	
}



if is_attacking == true
{
	//we dont want to be able to move while attacking (wind up)	
	h_speed = 0;
	v_speed = 0;
			
	//count down till attack comenses..(can be affected by player attacking us to stun*)
	time_till_attack -= 1;
		
	
	//break time_till attack original into equal fractions of the sprites image number
	//and if it gets less than the next segment (+1 to image number)

		
	if time_till_attack <= 0 and has_ended_attack_wind_up == false
	{
		has_ended_attack_wind_up = true;
		sprite_index = sprite_state_array[STATE.ATTACK];
		image_speed = 1;//whatever the normal play speed is
		
		alarm[0] = my_attack_reload_time;
	}






	if has_ended_attack_wind_up == true and sprite_index == sprite_state_array[STATE.ATTACK]
	{
			
		if floor(image_index) == image_number - 1
		{			
				
	
			direction = point_direction(x,y,obj_player.x,obj_player.y);
			
			with instance_create_depth(x + lengthdir_x(sprite_width,direction),y + lengthdir_y(sprite_width,direction),depth,obj_enemy_attack_collision)
			{
				my_damage = other.my_damage;
				sprite_index = other.my_attack_collision_image;
				direction = other.direction;
				image_angle = direction;				
			}
			
				
			sprite_index = sprite_state_array[STATE.WALK];
			
				
		}
	}
	

}






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


