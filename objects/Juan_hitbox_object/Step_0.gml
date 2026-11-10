x = owner.x
y = owner.y
if (owner.state == owner.stateHit){
	instance_destroy()
}

var golpeadosEnFrame = ds_list_create()
var golpes = instance_place_list(x, y, Tijereta, golpeadosEnFrame, false)
if (golpes > 0){
	
	for (var i = 0; golpes > i;i++){
	
		var hitID = ds_list_find_value(golpeadosEnFrame, i)
		
		
		if (ds_list_find_index(golpeados, hitID) == -1){
			ds_list_add(golpeados, hitID)
			with(hitID){
				Get_Hit()
				vel_x = 4* (x-other.x)/point_distance(x, y, other.x, other.y)
			}
		}
		
	}
}
