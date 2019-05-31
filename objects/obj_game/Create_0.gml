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


//boots list
enum BOOTS_LIST
{
	BASIC = PANTS_LIST.LAST_IN_LIST,
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
	WALK,
	DODGE_ROLL,
	ATTACK,
	ATTACK_WIND,
	LAST
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
//basic sword (wont be needed (add to grid...but ill change this later))
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


global.how_many_active_players = 1;

//for node set up
scr_initialize_level_nodes();





#region ALL items data-base
global.item_database_grid = ds_grid_create(3,0);

//materials
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.SLIME,ITEM_CLASS.MATERIAL);//item # 0 = slime
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.ICE_BLOCK,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.GOLD_GEM,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.PURPLE_GEM,ITEM_CLASS.MATERIAL);

//weapons
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.BASIC,ITEM_CLASS.WEAPON);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.SWORD_TWO,ITEM_CLASS.WEAPON);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.BASIC,ITEM_CLASS.WEAPON);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.BASIC,ITEM_CLASS.WEAPON);
scr_add_item_to_database_grid(spr_all_weapons,WEAPON_LIST.BASIC,ITEM_CLASS.WEAPON);


//helmets
scr_add_item_to_database_grid(spr_all_helmets,HELMETS_LIST.BASIC,ITEM_CLASS.HELMET);

//torso
scr_add_item_to_database_grid(spr_all_torsos,TORSO_LIST.BASIC,ITEM_CLASS.TORSO);

//pants
scr_add_item_to_database_grid(spr_all_pants,PANTS_LIST.BASIC,ITEM_CLASS.PANTS);

//boots
scr_add_item_to_database_grid(spr_all_boots,BOOTS_LIST.BASIC,ITEM_CLASS.BOOTS);

//rings
scr_add_item_to_database_grid(spr_all_rings,RING_LIST.BASIC,ITEM_CLASS.RING);

//gloves
scr_add_item_to_database_grid(spr_all_gloves,GLOVES_LIST.BASIC,ITEM_CLASS.GLOVES);





#endregion




#region craftable items recipe info
global.item_forge_grid = ds_grid_create(13,0);
	
//fill grid info

//weapons
scr_add_item_to_forge_grid(WEAPON_LIST.BASIC,"Starting sword",MATERIAL_LIST.SLIME,2,MATERIAL_LIST.ICE_BLOCK,1);
scr_add_item_to_forge_grid(WEAPON_LIST.SWORD_TWO,"The PURPLE sword of goodness",MATERIAL_LIST.GOLD_GEM,2,MATERIAL_LIST.SLIME,1,MATERIAL_LIST.PURPLE_GEM,3,MATERIAL_LIST.ICE_BLOCK,1);
scr_add_item_to_forge_grid(WEAPON_LIST.SWORD_3,"",0,2,1,1);
scr_add_item_to_forge_grid(WEAPON_LIST.SWORD_4,"",0,2,1,1);
scr_add_item_to_forge_grid(WEAPON_LIST.SWORD_5,"",0,2,1,1);

//helmets
scr_add_item_to_forge_grid(HELMETS_LIST.BASIC,"Starting helmet",MATERIAL_LIST.SLIME,1,MATERIAL_LIST.ICE_BLOCK,1,MATERIAL_LIST.PURPLE_GEM,3);

//torso
scr_add_item_to_forge_grid(TORSO_LIST.BASIC,"Starting torso",MATERIAL_LIST.SLIME,1);

//pants
//boots
//rings
//gloves




#endregion




has_started_fading = false;

fade_in_max_time = room_speed * 2;

my_alpha = 1.3;

depth = DEPTH.SMALLEST;




