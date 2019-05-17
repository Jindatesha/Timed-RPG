
/// @param item_number


//temp_variables_list = ds_list_create();


//if its a material
if my_item_number >= -1 and my_item_number < MATERIAL_LIST.LAST_IN_LIST 
{
	//ds_list_add(temp_variables_list,spr_item_drop_materials);
	//ds_list_add(temp_variables_list,0);
	//ds_list_add(temp_variables_list,ITEM_CLASS.MATERIAL);
	
	last_item_number = 0;
	sprite_index = spr_item_drop_materials;
	my_item_class = ITEM_CLASS.MATERIAL;
	
}
					
//if its a weapon
if my_item_number >= MATERIAL_LIST.LAST_IN_LIST and my_item_number < WEAPON_LIST.LAST_IN_LIST 
{
	last_item_number = MATERIAL_LIST.LAST_IN_LIST;
	sprite_index = spr_all_weapons;
	my_item_class = ITEM_CLASS.WEAPON;
}
					
//if its a boot
if my_item_number >= WEAPON_LIST.LAST_IN_LIST and my_item_number < BOOTS_LIST.LAST_IN_LIST 
{
	last_item_number = BOOTS_LIST.LAST_IN_LIST;
	sprite_index = spr_all_boots;
	my_item_class = ITEM_CLASS.BOOTS;
}
					
//if its a ring
if my_item_number >= BOOTS_LIST.LAST_IN_LIST and my_item_number < RING_LIST.LAST_IN_LIST 
{
	last_item_number = RING_LIST.LAST_IN_LIST;
	sprite_index = spr_all_rings;
	my_item_class = ITEM_CLASS.RING;
}
					
//if its a glove
if my_item_number >= RING_LIST.LAST_IN_LIST and my_item_number < GLOVES_LIST.LAST_IN_LIST 
{
	last_item_number = GLOVES_LIST.LAST_IN_LIST;
	sprite_index = spr_all_gloves;
	my_item_class = ITEM_CLASS.GLOVES;
}
					
//if its a torso/chest piece
if my_item_number >= GLOVES_LIST.LAST_IN_LIST and my_item_number < TORSO_LIST.LAST_IN_LIST 
{
	last_item_number = TORSO_LIST.LAST_IN_LIST;
	sprite_index = spr_all_torsos;
	my_item_class = ITEM_CLASS.TORSO;
}
					
					
//if its a pant piece/ legs slot
if my_item_number >= TORSO_LIST.LAST_IN_LIST and my_item_number < PANTS_LIST.LAST_IN_LIST 
{
	last_item_number = PANTS_LIST.LAST_IN_LIST;
	sprite_index = spr_all_pants;
	my_item_class = ITEM_CLASS.PANTS;
}

//if its a pant piece/ legs slot
if my_item_number >= PANTS_LIST.LAST_IN_LIST and my_item_number < HELMETS_LIST.LAST_IN_LIST 
{
	last_item_number = HELMETS_LIST.LAST_IN_LIST;
	sprite_index = spr_all_helmets;
	my_item_class = ITEM_CLASS.HELMET;
}












