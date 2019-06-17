


global.node_grid = ds_grid_create(5,6); //(vars, # of nodes)




var node_gap = sprite_get_width(spr_level_node) * 1.5;


//node 0 (center starting)
ds_grid_set(global.node_grid,0,0,0);//x (added from starting node)
ds_grid_set(global.node_grid,1,0,0);//y (added from starting node)
ds_grid_set(global.node_grid,2,0,NODE_TYPE.STARTING);//node type
ds_grid_set(global.node_grid,3,0,true);//already activated?(true/false)
ds_grid_set(global.node_grid,4,0,1.2);//list of threads ( this is the first created node)


//node 1 (small)
ds_grid_set(global.node_grid,0,1, (node_gap * 1));//x
ds_grid_set(global.node_grid,1,1,(node_gap * 1));//y
ds_grid_set(global.node_grid,2,1,NODE_TYPE.EMPTY);//node type
ds_grid_set(global.node_grid,3,1,false);//already activated?(true/false)
ds_grid_set(global.node_grid,4,1,0);//list of threads 



//node 2 (large - knockback)
ds_grid_set(global.node_grid,0,2,(node_gap * -1));//x
ds_grid_set(global.node_grid,1,2,(node_gap * 0));//y
ds_grid_set(global.node_grid,2,2,NODE_TYPE.EMPTY);//node type
ds_grid_set(global.node_grid,3,2,false);//already activated?(true/false)
ds_grid_set(global.node_grid,4,2,0.3);//list of threads 


//node 3 (small)
ds_grid_set(global.node_grid,0,3,(node_gap * -2));//x
ds_grid_set(global.node_grid,1,3,(node_gap * 1));//y
ds_grid_set(global.node_grid,2,3,NODE_TYPE.EMPTY);//node type
ds_grid_set(global.node_grid,3,3,false);//already activated?(true/false)
ds_grid_set(global.node_grid,4,3,2.4);//list of threads 

//node 4 (small)
ds_grid_set(global.node_grid,0,4,(node_gap * -3));//x
ds_grid_set(global.node_grid,1,4,(node_gap * 1));//y
ds_grid_set(global.node_grid,2,4,NODE_TYPE.EMPTY);//node type
ds_grid_set(global.node_grid,3,4,false);//already activated?(true/false)
ds_grid_set(global.node_grid,4,4,3.5);//list of threads 

//node 5 (small)
ds_grid_set(global.node_grid,0,5,(node_gap * -4));//x
ds_grid_set(global.node_grid,1,5,(node_gap * 1));//y
ds_grid_set(global.node_grid,2,5,NODE_TYPE.HEALTH);//node type
ds_grid_set(global.node_grid,3,5,true);//already activated?(true/false)
ds_grid_set(global.node_grid,4,5,4);//list of threads 