vida = 3
target = Juan
gravedad = 0.4
vel_y = 0.0
max_vel_y = 15
vel_x = 1
var guard_timer = 90
var attack_timer = 25

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
Ataque = function(){
	image_index = 0
	sprite_index = tijereta_attack
	with (instance_create_layer(x, y, "Instances", hitbox_object)){
		owner = other.id
		target = Juan
		sprite_index = tijereta_attack_hitbox
		image_xscale = other.image_xscale
						
	}
	state = stateAttack
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
	image_xscale = sign(x-target.x)
	
	if !(300 > abs(x-target.x) and 80 > abs(y-target.y)){
		guard_timer--
		image_index = 0
		sprite_index = tijereta_idle
		if (0 > guard_timer){
			
			state = stateRoam
		}
	}else{
		guard_timer = 90
		sprite_index = tijereta_guardia
	}
	
	if (45 > abs(x-target.x) and 30 > abs(y-target.y)){
		attack_timer--
		if (0 > attack_timer){
			
			Ataque()
		}
	}else{
		attack_timer = 25
		
	}
}
stateAttack = function(){
	Aplicar_gravedad()

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
