/// @description Insert description here
// You can write your code in this editor


enum POTENTIAL_STATE
{
	SIDE,
	UP,
	DOWN,
	DIAG_UP,
	DIAG_DOWN,
	DODGE_ROLL_SIDE,
	DODGE_ROLL_UP,
	DODGE_ROLL_DOWN,
	DODGE_ROLL_DIAG_UP,
	DODGE_ROLL_DIAG_DOWN,
	ATTACK_SIDE,
	ATTACK_UP,
	ATTACK_DOWN,
	ATTACK_DIAG_UP,
	ATTACK_DIAG_DOWN
	
	
}


#macro view view_camera[0]
#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)
#macro view_ratio surface_get_width(application_surface)/view_w



enum DEPTH
{
	CURSOR = -15,
	BELOW_CURSOR = -14,
	SMALLEST = -9,
	PLAYER = 0,
	ENEMY,
	ITEM_ON_FLOOR,
	FLOOR 
	
}



enum WEAPON_ATTRIBUTE
{
	SPRITE,
	IMAGE_SPEED,
	DAMAGE,
	COLLISION_SPRITE,
	COLLISION_NUMBER

}


/*
0 = wep 1
1 = wep 2

2 = glove
3 = ring
4 = boots

5 = helmet
6 = torso
7 = legs
*/
enum ITEM_CLASS
{
	ANYTHING,
	MATERIAL,
	WEAPON,
	RING,
	GLOVES,
	PANTS,
	TORSO,
	HELMET,
	BOOTS
	
}


enum MONSTER
{
	SLIME
}


//material list
enum MATERIAL_LIST
{
	NOTHING = -1,
	SLIME = 0,
	ICE_BLOCK,
	GOLD_GEM,
	PURPLE_GEM,
	LAST_IN_LIST
	
}

//weapons list
enum WEAPON_LIST
{
	BASIC = MATERIAL_LIST.LAST_IN_LIST,
	SWORD_TWO,
	SWORD_3,
	SWORD_4,
	SWORD_5,
	LAST_IN_LIST
}

//boots list
enum BOOTS_LIST
{
	BASIC = WEAPON_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//ring list
enum RING_LIST
{
	BASIC = BOOTS_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//gloves list
enum GLOVES_LIST
{
	BASIC = RING_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//torso list
enum TORSO_LIST
{
	BASIC = GLOVES_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//pants list
enum PANTS_LIST
{
	BASIC = TORSO_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//pants list
enum HELMETS_LIST
{
	BASIC = PANTS_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}



enum FADE
{
	IN = 1,
	OUT = -1
}




slime_list_1 = ds_list_create();
ds_list_add(slime_list_1,MATERIAL_LIST.NOTHING);

slime_list_2 = ds_list_create();
ds_list_add(slime_list_2,MATERIAL_LIST.SLIME);

slime_list_3 = ds_list_create();
ds_list_add(slime_list_3,MATERIAL_LIST.ICE_BLOCK);


//% and a list of what that drop entails 
slime_drop_list = ds_list_create();
ds_list_add(slime_drop_list,60,slime_list_1,35,slime_list_2,5,slime_list_3);




global.monster_drop_list = ds_list_create(); 
ds_list_add(global.monster_drop_list,slime_drop_list);



// WEAPONS
//basic sword
global.weapons_array[0,WEAPON_ATTRIBUTE.SPRITE] = spr_weapon_sword_basic;
global.weapons_array[0,WEAPON_ATTRIBUTE.IMAGE_SPEED] = 1.45;
global.weapons_array[0,WEAPON_ATTRIBUTE.DAMAGE] = 25;
global.weapons_array[0,WEAPON_ATTRIBUTE.COLLISION_SPRITE] = spr_weapon_sword_basic_collision;
global.weapons_array[0,WEAPON_ATTRIBUTE.COLLISION_NUMBER] = 4;




//globals
global.player_has_attacked = false;

global.width = 3200;
global.height = 1800;


global.freeze_character = false;

global.transition_fade_alpha = 1;


global.can_move_towards_mouse = true;







has_started_fading = false;

fade_in_max_time = room_speed * 2;

my_alpha = 1.3;

depth = DEPTH.SMALLEST;




