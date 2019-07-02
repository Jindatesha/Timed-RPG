/// @description Insert description here
// You can write your code in this editor




#macro view view_camera[0]
#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)
#macro view_ratio surface_get_width(application_surface)/view_w



enum DEPTH
{
	CURSOR = -30,
	BELOW_CURSOR = -14,
	SMALLEST = -9,
	PLAYER = 0,
	ENEMY,
	ITEM_ON_FLOOR,
	FLOOR 
	
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


enum WEAPON_LIST
{
	//BASIC = MATERIAL_LIST.LAST_IN_LIST,
	KATANA = MATERIAL_LIST.LAST_IN_LIST,
	SWORD_AND_SHIELD,
	SCYTHE,
	BOW,
	LAST_IN_LIST
}


//helmets list
enum HELMETS_LIST
{
	BASIC = WEAPON_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}


//torso list
enum TORSO_LIST
{
	BASIC = HELMETS_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}

//pants list
enum PANTS_LIST
{
	BASIC = TORSO_LIST.LAST_IN_LIST,
	LAST_IN_LIST
}


enum UTILITY_LIST
{
	DUMMY,
	GRAPPLING_HOOK
}








enum WEAPON_ATTRIBUTE
{
	BASIC_ATTACK_1,
	BASIC_ATTACK_2,
	BASIC_ATTACK_3,
	IMAGE_SPEED,
	DAMAGE_SCALE_FACTOR,
	COLLISION_SPRITE,
	COLLISION_NUMBER,
	BASIC_ATTACK_COOLDOWN,
	MAX_WEAPON_DAMAGE_SCALE

}








enum FADE
{
	IN = 1,
	OUT = -1
}



//monstertype and room_number are for the spawn system
//monster types
enum MONSTER_TYPE
{
	SLIME = obj_enemy_slime
}



//what room are we in?
enum ROOM_NUMBER
{
	NO_ENEMY_ZONE = -1,
	SLIME_ZONE = 0
}



//state the player or enemy is in...and will determine their sprite index
enum STATE
{
	IDLE,
	WALK,
	DODGE_ROLL,
	ATTACK,
	ATTACK_WIND,
	ATTACK_SPECIAL,
	LAST
}





slime_list_1 = ds_list_create();
ds_list_add(slime_list_1,MATERIAL_LIST.NOTHING);

slime_list_2 = ds_list_create();
ds_list_add(slime_list_2,WEAPON_LIST.KATANA);

slime_list_3 = ds_list_create();
ds_list_add(slime_list_3,WEAPON_LIST.KATANA);


//% and a list of what that drop entails 
slime_drop_list = ds_list_create();
ds_list_add(slime_drop_list,60,slime_list_1,35,slime_list_2,5,slime_list_3);




global.monster_drop_list = ds_list_create(); 
ds_list_add(global.monster_drop_list,slime_drop_list);



// WEAPONS
global.weapons_grid = ds_grid_create(9,0);

scr_add_weapon_to_database_grid(spr_weapon_sword_basic,spr_weapon_sword_basic_combo_1,spr_weapon_sword_basic_combo_2,1.45,1.2,spr_weapon_sword_basic_collision,4,0,1.2);







//globals
global.player_has_attacked = false;

global.width = 3840;
global.height = 2160;


global.freeze_character = false;

global.transition_fade_alpha = 1;


global.can_move_towards_mouse = true;




enum THIS_ITEMS
{
	SPRITE_INDEX = 0,
	IMAGE_INDEX,
	ITEM_CLASS
}



enum NODE_TYPE
{
	EMPTY,
	STARTING,
	STRENGTH,
	DEXTERITY,
	INTELLEGENCE,
	HEALTH,
	KNOCKBACK
}


enum ITEM_SET_BONUS
{
	NONE
}



enum EQUIPMENT_STATS
{
	HP = 4
}



enum PLAYER_STATS
{
	NOTHING = -1,
	HEALTH = 0,
	STRENGTH,
	ATTACK_SPEED,
	CRIT_CHANCE,
	LAST_IN_LIST
	
}


enum EQUIPMENT_RARITY
{
	COMMON,
	RARE,
	LEGENDARY

}


global.how_many_active_players = 1;

//for node set up
scr_initialize_level_nodes();





#region ALL items data-base
global.item_database_grid = ds_grid_create(5,0);

//materials
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.SLIME,ITEM_CLASS.MATERIAL);//item # 0 = slime
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.ICE_BLOCK,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.GOLD_GEM,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.PURPLE_GEM,ITEM_CLASS.MATERIAL);

//weapons
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.KATANA,ITEM_CLASS.WEAPON,ITEM_SET_BONUS.NONE);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.KATANA,ITEM_CLASS.WEAPON,ITEM_SET_BONUS.NONE);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.KATANA,ITEM_CLASS.WEAPON,ITEM_SET_BONUS.NONE);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.KATANA,ITEM_CLASS.WEAPON,ITEM_SET_BONUS.NONE);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.KATANA,ITEM_CLASS.WEAPON,ITEM_SET_BONUS.NONE);


//helmets
scr_add_item_to_database_grid(spr_all_helmets,HELMETS_LIST.BASIC,ITEM_CLASS.HELMET,ITEM_SET_BONUS.NONE,0);

//torso
scr_add_item_to_database_grid(spr_all_torsos,TORSO_LIST.BASIC,ITEM_CLASS.TORSO,ITEM_SET_BONUS.NONE,100);

//pants
scr_add_item_to_database_grid(spr_all_pants,PANTS_LIST.BASIC,ITEM_CLASS.PANTS,ITEM_SET_BONUS.NONE,300);





#endregion




#region craftable items recipe info
global.item_forge_grid = ds_grid_create(13,0);
	
//fill grid info

//weapons
scr_add_item_to_forge_grid(WEAPON_LIST.KATANA,"Starting sword",MATERIAL_LIST.SLIME,2,MATERIAL_LIST.ICE_BLOCK,1);
scr_add_item_to_forge_grid(WEAPON_LIST.KATANA,"The PURPLE sword of goodness",MATERIAL_LIST.GOLD_GEM,2,MATERIAL_LIST.SLIME,1,MATERIAL_LIST.PURPLE_GEM,3,MATERIAL_LIST.ICE_BLOCK,1);
scr_add_item_to_forge_grid(WEAPON_LIST.KATANA,"",0,2,1,1);
scr_add_item_to_forge_grid(WEAPON_LIST.KATANA,"",0,2,1,1);
scr_add_item_to_forge_grid(WEAPON_LIST.KATANA,"",0,2,1,1);

//helmets
scr_add_item_to_forge_grid(HELMETS_LIST.BASIC,"Starting helmet",MATERIAL_LIST.SLIME,1,MATERIAL_LIST.ICE_BLOCK,1,MATERIAL_LIST.PURPLE_GEM,3);

//torso
scr_add_item_to_forge_grid(TORSO_LIST.BASIC,"Starting torso",MATERIAL_LIST.SLIME,1);

//pants
scr_add_item_to_forge_grid(PANTS_LIST.BASIC,"Starting pantsss man",MATERIAL_LIST.SLIME,2);




#endregion




has_started_fading = false;

fade_in_max_time = room_speed * 2;

my_alpha = 1.3;

depth = DEPTH.SMALLEST;


global.time = 0;

var seconds = 60;
var minutes = 15;


global.time_until_boss = room_speed * (seconds) * (minutes)

has_spawned_boss = false;


