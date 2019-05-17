/// @description returns item_number
/// @param sprite_index
/// @param image_index



switch(argument[0])
{
	default:
	case spr_item_drop_materials:
		return image_index;
	break;

	case spr_all_weapons:
		return image_index + MATERIAL_LIST.LAST_IN_LIST;
	break;

}


