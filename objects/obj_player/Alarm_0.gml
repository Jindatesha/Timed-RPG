///reset variables if player dodgerolled

//turn the statemachine back on (was off to prevent state switches on attacks or dodgerolls)
can_switch_state = true;
can_control_player = true;
is_dodge_rolling = false;

my_weapons[current_weapon].visible = true;

image_xscale = x_scale_before_dodge_roll;


