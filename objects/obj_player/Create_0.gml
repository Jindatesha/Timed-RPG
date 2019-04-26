/// @description Insert description here
// You can write your code in this editor

//normal movement
player_state[PLAYER_STATE.LEFT] = spr_player_move_left;
player_state[PLAYER_STATE.RIGHT] = spr_player_move_right;
player_state[PLAYER_STATE.UP] = spr_player_move_up;
player_state[PLAYER_STATE.DOWN] = spr_player_move_down;
player_state[PLAYER_STATE.DIAG_UP_LEFT] = spr_player_move_diag_up_left;
player_state[PLAYER_STATE.DIAG_UP_RIGHT] = spr_player_move_diag_up_right;
player_state[PLAYER_STATE.DIAG_DOWN_LEFT] = spr_player_move_diag_down_left;
player_state[PLAYER_STATE.DIAG_DOWN_RIGHT] = spr_player_move_diag_down_right;
//dodgeroll
player_state[PLAYER_STATE.DODGE_ROLL_LEFT] = spr_player_move_dodge_roll_left;
player_state[PLAYER_STATE.DODGE_ROLL_RIGHT] = spr_player_move_dodge_roll_right;
player_state[PLAYER_STATE.DODGE_ROLL_UP] = spr_player_move_dodge_roll_up;
player_state[PLAYER_STATE.DODGE_ROLL_DOWN] = spr_player_move_dodge_roll_down;
player_state[PLAYER_STATE.DODGE_ROLL_DIAG_UP_LEFT] = spr_player_move_dodge_roll_diag_up_left;
player_state[PLAYER_STATE.DODGE_ROLL_DIAG_UP_RIGHT] = spr_player_move_dodge_roll_diag_up_right;
player_state[PLAYER_STATE.DODGE_ROLL_DIAG_DOWN_LEFT] = spr_player_move_dodge_roll_diag_down_left;
player_state[PLAYER_STATE.DODGE_ROLL_DIAG_DOWN_RIGHT] = spr_player_move_dodge_roll_diag_down_right;


my_state = player_state[PLAYER_STATE.RIGHT];
can_switch_state = true;

image_speed = 0.4;

//how fast the player can normally move
move_speed = 3;

mouse_dir = 0;

can_control_player = true;

depth = DEPTH.PLAYER;


olde_h_speed = 0; 
olde_v_speed = 0; 
dodge_roll_speed = 3; //when dodge rolling ... move 40% faster
dodge_roll_dir = 0;

