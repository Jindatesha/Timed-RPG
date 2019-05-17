

//normal movement
potential_state[POTENTIAL_STATE.SIDE] = spr_player_move_side;
potential_state[POTENTIAL_STATE.UP] = spr_player_move_up;
potential_state[POTENTIAL_STATE.DOWN] = spr_player_move_down;
potential_state[POTENTIAL_STATE.DIAG_UP] = spr_player_move_diag_up;
potential_state[POTENTIAL_STATE.DIAG_DOWN] = spr_player_move_diag_down;

//dodgeroll
potential_state[POTENTIAL_STATE.DODGE_ROLL_SIDE] = spr_player_move_dodge_roll_side;
potential_state[POTENTIAL_STATE.DODGE_ROLL_UP] = spr_player_move_dodge_roll_up;
potential_state[POTENTIAL_STATE.DODGE_ROLL_DOWN] = spr_player_move_dodge_roll_down;
potential_state[POTENTIAL_STATE.DODGE_ROLL_DIAG_UP] = spr_player_move_dodge_roll_diag_up;
potential_state[POTENTIAL_STATE.DODGE_ROLL_DIAG_DOWN] = spr_player_move_dodge_roll_diag_down;


current_state = potential_state[POTENTIAL_STATE.SIDE];
can_switch_state = true;

image_speed = 0.4;

//how fast the player can normally move
move_speed = 10;

mouse_dir = 0;

can_control_player = true;

starting_depth = DEPTH.PLAYER
depth = starting_depth;


olde_h_speed = 0; 
olde_v_speed = 0; 
dodge_roll_speed = 3; //this is a multiplier to ur move_speed
dodge_roll_dir = 0;
is_dodge_rolling = false;


//our players collision mask
mask_index = spr_player_collision_mask;
//sprite_set_offset(spr_player_collision_mask,16,16);




//what is the current weapon
current_weapon = 0;


//give the player their first weapon
with (instance_create_depth(x,y,DEPTH.PLAYER,obj_weapon))
{
	owner = other.id;
	owner.my_weapons[0] = id;
	my_weapon_number = 0;
	sprite_index = global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.SPRITE];
	my_damage = global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.DAMAGE];
	mask_index = global.weapons_array[my_weapon_number,WEAPON_ATTRIBUTE.COLLISION_SPRITE];
	my_item_number = MATERIAL_LIST.LAST_IN_LIST;
	my_item_class = ITEM_CLASS.WEAPON;
}

switch_hand_degree_margin = 20;
weapon_hand = 1;//1 = right hand  -1 = left hand
hand_dir = 0; //degree in which the arms will "bend" until the weapon is swapped to the other hand

x_scale_before_dodge_roll = 1;

attack_thrust_amount = 60;
attack_thrust_total_frames = room_speed * 0.13;
attack_thrust_current_frame = 0;


my_max_hp = 1000;
my_hp = my_max_hp;
hp_lossed = 0;
show_health_reduction_timer = 0;
show_health_max_reduction_time = room_speed * 0.6;


starting_inventory_x = 0;
starting_inventory_y = 0;
inventory_on = -1;//-1 is off by default (1 = on)


inventory_list = ds_list_create();

/*
0 = wep 1
1 = wep 2

2 = glove
3 = ring
4 = boots

5 = helmet
6 = torso
7 = legs

8 -> ?? = left -> right then down one row
ie:
8,9,10
11,12,13
*/

//weapon slots
ds_list_add(inventory_list,my_weapons[0].my_item_number,-1);

//equipment slots
ds_list_add(inventory_list,-1,-1,-1,-1,-1,-1);

//normal
ds_list_add(inventory_list,-1,-1,-1,-1,-1,-1,-1,-1,-1);


//create array of all the slot positions in our inventory
inventory_slots_pos_array[0,0] = 470;//x
inventory_slots_pos_array[0,1] = 910;//y
inventory_slots_pos_array[1,0] = 820;//x
inventory_slots_pos_array[1,1] = 910;//y
inventory_slots_pos_array[2,0] = 248;//x
inventory_slots_pos_array[2,1] = 180;//y
inventory_slots_pos_array[3,0] = 248;//x
inventory_slots_pos_array[3,1] = 430;//y
inventory_slots_pos_array[4,0] = 248;//x
inventory_slots_pos_array[4,1] = 680;//y
inventory_slots_pos_array[5,0] = 1043;//x
inventory_slots_pos_array[5,1] = 180;//y
inventory_slots_pos_array[6,0] = 1043;//x
inventory_slots_pos_array[6,1] = 430;//y
inventory_slots_pos_array[7,0] = 1043;//x
inventory_slots_pos_array[7,1] = 680;//y
inventory_slots_pos_array[8,0] = 1460;//x
inventory_slots_pos_array[8,1] = 210;//y
inventory_slots_pos_array[9,0] = 1680;//x
inventory_slots_pos_array[9,1] = 210;//y
inventory_slots_pos_array[10,0] = 1890;//x
inventory_slots_pos_array[10,1] = 210;//y
inventory_slots_pos_array[11,0] = 1460;//x
inventory_slots_pos_array[11,1] = 410;//y
inventory_slots_pos_array[12,0] = 1680;//x
inventory_slots_pos_array[12,1] = 410;//y
inventory_slots_pos_array[13,0] = 1890;//x
inventory_slots_pos_array[13,1] = 410;//y
inventory_slots_pos_array[14,0] = 1460;//x
inventory_slots_pos_array[14,1] = 610;//y
inventory_slots_pos_array[15,0] = 1680;//x
inventory_slots_pos_array[15,1] = 610;//y
inventory_slots_pos_array[16,0] = 1890;//x
inventory_slots_pos_array[16,1] = 610;//y








