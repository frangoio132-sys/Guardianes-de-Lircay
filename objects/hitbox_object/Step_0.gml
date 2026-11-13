

// logica solo para juan

if owner.object_index == Juan{
	if owner.is_on_floor {
		if sprite_index == Juan_hitbox_air_attack{
			sprite_index = Juan_hitbox_landing_attack
		}else if image_angle == 90 or image_angle == 270{
			if image_index > 2{
				image_index -= 2
			}
			image_angle = 0
			sprite_index = Juan_hitbox_1
		}
	}

}

if !instance_exists(owner){
	instance_destroy()
}else{
	if (owner.state == owner.stateHit){
		instance_destroy()
	}
	x = owner.x
	y = owner.y
}



var golpeadosEnFrame = ds_list_create()
var golpes = instance_place_list(x, y, target, golpeadosEnFrame, false)

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
