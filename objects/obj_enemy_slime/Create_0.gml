/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

my_attack_reload_time = room_speed * 2;

my_respawn_rate = room_speed * 17;

sprite_state_array[STATE.WALK] = spr_enemy_slime_move_side;
sprite_state_array[STATE.ATTACK_WIND] = spr_enemy_slime_attack_wind_up;
sprite_state_array[STATE.ATTACK] = spr_enemy_slime_attack;

time_till_attack = 0;

has_ended_attack_wind_up = false;

my_attack_wind_up_time = room_speed * 1;

my_attack_length = 130; //px possible attack length



