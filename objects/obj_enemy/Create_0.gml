/// @description Insert description here
// You can write your code in this editor

my_max_hp = 100;
my_hp = my_max_hp;
my_speed = 1.7;
show_health_timer = 0;
my_range = 400;
show_health_max_time = room_speed * 0.6;
hp_lossed = 0;
my_damage = 150;

depth = DEPTH.ENEMY;

mask_index = spr_enemy_slime_collision;

my_respawn_rate = room_speed * 2;


can_attack = true;

my_attack_reload_time = room_speed * 2;

can_move = true;
can_switch_state = true;

//normal movement
potential_state[POTENTIAL_STATE.SIDE] = spr_enemy_slime_move_side;
potential_state[POTENTIAL_STATE.UP] = spr_enemy_slime_move_up;
potential_state[POTENTIAL_STATE.DOWN] = spr_enemy_slime_move_down;
potential_state[POTENTIAL_STATE.DIAG_UP] = spr_enemy_slime_move_diag_up;
potential_state[POTENTIAL_STATE.DIAG_DOWN] = spr_enemy_slime_move_diag_down;

potential_state[POTENTIAL_STATE.ATTACK_SIDE] = spr_enemy_slime_move_side;
potential_state[POTENTIAL_STATE.ATTACK_UP] = spr_enemy_slime_move_up;
potential_state[POTENTIAL_STATE.ATTACK_DOWN] = spr_enemy_slime_move_down;
potential_state[POTENTIAL_STATE.ATTACK_DIAG_UP] = spr_enemy_slime_move_diag_up;
potential_state[POTENTIAL_STATE.ATTACK_DIAG_DOWN] = spr_enemy_slime_move_diag_down;


is_attacking = false;

has_done_hit_collisions = false;
my_attack_collision_image = spr_enemy_slime_attack_collision;
my_attack_range = sprite_get_width(my_attack_collision_image) * 0.8;

my_monster_type = MONSTER.SLIME;



