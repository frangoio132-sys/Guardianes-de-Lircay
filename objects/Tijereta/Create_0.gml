vida = 3
target = Juan
gravedad = 0.4
vel_y = 0.0
max_vel_y = 15
vel_x = 1


Aplicar_gravedad = function(){
	 if place_meeting(x, y+vel_y, Obj_wall) { 
		// aaskjd
		while (!place_meeting(x, y+sign(vel_y), Obj_wall)){
			y+= sign(vel_y)
		}
		vel_y = 0

	}else{ //si esta en el aire
	
		y += vel_y
		if max_vel_y > vel_y{ 
			vel_y += gravedad
		}
	}
	
}

stateHit = function(){
	Aplicar_gravedad()
	if !place_meeting(x+vel_x, y, Obj_wall){
		x += vel_x	
	}
	if is_on_floor{
		vel_x = lerp(vel_x, 0, 0.2)
	}else{
		vel_x = lerp(vel_x, 0, 0.01)
	}
}
stateRoam = function(){
	Aplicar_gravedad()
	image_xscale = -sign(vel_x)
	if place_meeting(x + vel_x, y, Obj_wall) { //todo este chanchullo es para que cam
		if !place_meeting(x + vel_x, y-11, Obj_wall) {
			y -= 11
			x += vel_x
		}else{
			vel_x = -vel_x
		}
	}
	if !place_meeting(x + 50 *sign(vel_x), y+15, Obj_wall){  //para que se de vuelta antes de que se caiga
		vel_x = -vel_x
	}
	x+=vel_x

	if (300 > abs(x-target.x) and 80 > abs(y-target.y)){
		image_index = 0
		image_xscale = sign(x-target.x)
		sprite_index = tijereta_guardia
		state = stateGuard
	}
	
	
}
stateGuard = function(){
	Aplicar_gravedad()
	if !(300 > abs(x-target.x) and 80 > abs(y-target.y)){
		image_index = 0
		sprite_index = tijereta_idle
		state = stateRoam
	}
}

Get_Hit = function(){
	alarm_set(0, 15)
	vida--
	vel_y = -3
	if (0  >= vida ){
		instance_destroy()
	}
	state = stateHit
}

state = stateRoam
