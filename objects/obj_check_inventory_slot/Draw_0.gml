/// @description Insert description here
// You can write your code in this editor



draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var slot_name = "name"

switch(my_slot_class)
{
	case ITEM_CLASS.ANYTHING:
		slot_name = "anything";
	break
	
	case ITEM_CLASS.HELMET:
		slot_name = "helmet";
	break
	
	case ITEM_CLASS.TORSO:
		slot_name = "torso";
	break
	
	case ITEM_CLASS.PANTS:
		slot_name = "pants";
	break
	
	case ITEM_CLASS.BOOTS:
		slot_name = "boots";
	break
	
	case ITEM_CLASS.RING:
		slot_name = "ring";
	break
	
	case ITEM_CLASS.WEAPON:
		slot_name = "weapon";
	break
	
	case ITEM_CLASS.MATERIAL:
		slot_name = "material";
	break
	
	case ITEM_CLASS.GLOVES:
	slot_name = "gloves";
	break
}

draw_text(x,y,string(slot_name));


