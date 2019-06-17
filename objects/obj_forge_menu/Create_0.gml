/// @description Insert description here
// You can write your code in this editor



hovered_tab = 0; //default tab selected
selected_tab = 0;




//find out how many sheets are needed for each list

//weapon
//helmet
//torso
//pants
//boots
//ring
//gloves

var how_many_sheets = 0;
var starting_list_number = 0;

for(var i = 0; i < 7; i += 1;)
{
	switch(i)
	{
		case 0:
			how_many_sheets = WEAPON_LIST.LAST_IN_LIST - WEAPON_LIST.BASIC;
			starting_list_number = WEAPON_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 1:
			how_many_sheets = HELMETS_LIST.LAST_IN_LIST - HELMETS_LIST.BASIC;
			starting_list_number = HELMETS_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 2:
			how_many_sheets = TORSO_LIST.LAST_IN_LIST - TORSO_LIST.BASIC;
			starting_list_number = TORSO_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 3:
			how_many_sheets = PANTS_LIST.LAST_IN_LIST - PANTS_LIST.BASIC;
			starting_list_number = PANTS_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 4:
			how_many_sheets = BOOTS_LIST.LAST_IN_LIST - BOOTS_LIST.BASIC;
			starting_list_number = BOOTS_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 5:
			how_many_sheets = RING_LIST.LAST_IN_LIST - RING_LIST.BASIC;
			starting_list_number = RING_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
		
		case 6:
			how_many_sheets = GLOVES_LIST.LAST_IN_LIST - GLOVES_LIST.BASIC;
			starting_list_number = GLOVES_LIST.BASIC - MATERIAL_LIST.LAST_IN_LIST;
		break;
	}
	
	how_many_total_items_in_this_item_type_array[i] = how_many_sheets;
	starting_list_number_array[i] = starting_list_number;

}



sheets_surface = surface_create(1206,1319);



scroll_amount = 0;


check = 0;




