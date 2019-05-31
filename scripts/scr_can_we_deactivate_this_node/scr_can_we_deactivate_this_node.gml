//returns true or false

//can I be deactivated/ this node?
var I_can_be_deactivated = false;
var solved = false;		
global.looped_times = -1;
var go_to_the_beginning = false;

//quick check...were you already a confirmed node / werent changed this turn right?
if was_changed_this_turn == false and activated == true
{
	// ...cuz if so then you cant change ur mind on set nodes...
	//then you cant be deactivated
	I_can_be_deactivated = false;
	return 	I_can_be_deactivated;
}




while(solved == false)
{

	//loop through as many times as you need
	
	#region make a list of all active nodes 



	global.looped_times += 1;
		
	if global.looped_times == 0
	{
		global.checking_node[global.looped_times] = my_node_number;
	}
	else
	{
		global.checking_node[global.looped_times] = instance_find(obj_node,ds_list_find_value(global.list[global.looped_times - 1],0)).my_node_number;
	}
	
	
	global.list[global.looped_times] = ds_list_create();
	
	#endregion	
	
		
	#region look through our nodes for all active nodes and exclude the previous lists node 
	for(var l = 0; l < ds_list_size(instance_find(obj_node,global.checking_node[global.looped_times]).this_nodes_thread_list); l += 1;)
	{			
		
		
		//so we dont get stuck in a loop
		if go_to_the_beginning == true
		{
			//go directly to the beginning of this while loop; do NOT pass go
			break;
		}
		
		
		#region ADDS ALL ACTIVE THREADS OF THIS NODE TO A LIST AND ARE ONLY ACTIVATED THIS TURN
		with instance_find(obj_node,ds_list_find_value(instance_find(obj_node,global.checking_node[global.looped_times]).this_nodes_thread_list,l)) 
		{
			if activated == true
			{
				//not the main list
				if global.looped_times != 0
				{
					if my_node_number != global.checking_node[global.looped_times - 1]//exclude last lists node
					{
						if was_changed_this_turn == true
						{
							ds_list_add(global.list[global.looped_times],my_node_number);
						}
						else
						{
							
				
							var looping = true;
							
							while(looping == true)
							{	
								
								//remove this one from the previous list 
								//get which position our node is in the last list
								var index = ds_list_find_index(global.list[global.looped_times - 1],global.checking_node[global.looped_times]);
								//delete that entry
								ds_list_delete(global.list[global.looped_times - 1],index);
				
								ds_list_destroy(global.list[global.looped_times]);
				
								global.checking_node[global.looped_times] = 0;
								global.list[global.looped_times] = 0;
				
				
								global.looped_times -= 1;																
								
								
								//check the last list if it is empty
								if ds_list_size(global.list[global.looped_times]) == 0
								{
									if global.looped_times == 0
									{
										I_can_be_deactivated = true;
										return 	I_can_be_deactivated;
										//exit;
									}
								}
								else
								{
									//since we removed this node from the last list, and the last list has more nodes to check...go through the entire main while loop again
									looping = false;//this is not needed
									//breaks out of this loop
									break;
								}							
							}
							
							
							go_to_the_beginning = true;
							//breaks out of the with function
							//break;
							
							
						}
					}
				}
				else
				{
										
					if was_changed_this_turn == true
					{
						
						ds_list_add(global.list[global.looped_times],my_node_number);
					}
				}
			}
		}
		#endregion
		
	}
	
	#endregion
		
		
		
		
		if go_to_the_beginning == true
		{
			 go_to_the_beginning = false;
			//go back to the beginning of this while loop; 
			continue;
		}
		
		
			
		//check to see if the list is empty
		if ds_list_size(global.list[global.looped_times]) == 0
		{
			//~~~~if you are the main list/node
			if global.looped_times == 0
			{	
				
				//then you can be deactivated
				I_can_be_deactivated = true;
				return 	I_can_be_deactivated;
			}
			else
			{
				//~~~~~if NOT the main list then REMOVE our node from the previous list and destroy our list
				
				
				
				var looping = true;
				while(looping == true)
				{
					
					//get which position our node is in the last list
					var index = ds_list_find_index(global.list[global.looped_times - 1],global.checking_node[global.looped_times]);
					//delete that entry
					ds_list_delete(global.list[global.looped_times - 1],index);
				
					ds_list_destroy(global.list[global.looped_times]);
				
					global.checking_node[global.looped_times] = 0;
					global.list[global.looped_times] = 0;
				
				
					global.looped_times -= 1;
					
					
					
					
					
					if global.looped_times == 0
					{
						
						//check the last list if it is empty
						if ds_list_size(global.list[global.looped_times]) == 0
						{
							//A) they rely on you and you are their home...cant leave them
							I_can_be_deactivated = false;
							return 	I_can_be_deactivated;
						}
						//else
						
						
						looping = false;						
					}
					else
					{
						//check the last list if it is not empty
						if ds_list_size(global.list[global.looped_times]) > 0
						{						
							looping = false;							
						}
						
						
						
					}
				}
				
				
			
				//break;
				//delete entry in array? or does it get removed by default?
				
			}
		}
		
		
		
		
			//ELSE list is not empty
			
			//finish this and do the loop again
		
			//go back through the loop but with each of the nodes in our list
			
	
}		
		