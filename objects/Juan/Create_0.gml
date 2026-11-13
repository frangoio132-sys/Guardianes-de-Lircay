

gravedad = 0.4
vel_y = 0.0
max_vel_y = 15
vel_x = 0
floor_friction = 1
air_friction  = 0.01
air_SPEED = 9
floor_SPEED = 2

key_right =  (keyboard_check(vk_right) or keyboard_check(ord("D")))
key_left  =  (keyboard_check(vk_left) or keyboard_check(ord("A")))

directionx = key_right - key_left

key_up =  (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(vk_space))
key_down  =  (keyboard_check(vk_down) or keyboard_check(ord("S")))

is_on_floor = place_meeting(x, y+1, Obj_wall) and vel_y >= 0

directiony = key_down - key_up

Get_Hit = function(){
	image_index = 0
	sprite_index = Juan_Hit
	alarm_set(0, 10)
	state = stateHit
}

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
	
Aplicar_vuelo = function(){
	if place_meeting(x, y+vel_y, Obj_wall){ 
		// aaskjd
		while (!place_meeting(x, y+sign(vel_y), Obj_wall)){
			y+= sign(vel_y)
		}
		vel_y = 0

	}else{ //si esta en el aire
	
		y += vel_y
		if directiony > 0{	
			// esto pone  un limite para que no caiga demasiado rapido
			if max_vel_y > vel_y{ 
				vel_y += gravedad
			}
		}else if directiony == 0{
			vel_y = lerp(vel_y, 0.5, 0.1)
		}
	
	}
}
	
Attack_1 = function(){
	if directionx != 0{
		image_xscale = directionx
	}
	directionx = 0
	image_index = 0
	sprite_index = Juan_attack_1
	with (instance_create_layer(x, y, "Instances", hitbox_object)){
		owner = other.id
		target = Tijereta
		sprite_index = Juan_hitbox_1
		image_xscale = other.image_xscale
						
	}
	state = stateAttack
}

Attack_2= function(){
	if directionx != 0{
		image_xscale = directionx
	}
	directionx = 0
	image_index = 0
	sprite_index = Juan_attack_2
	with (instance_create_layer(x, y, "Instances", hitbox_object)){
		owner = other.id
		target = Tijereta
		sprite_index = Juan_hitbox_2
		image_xscale = other.image_xscale
						
	}
	state = stateAttack
}

Attack_air = function(){
	if directionx != 0{
		image_xscale = directionx
	}
	var dir = 0
	directionx = 0
	image_index = 0
	if key_up{
		dir = 180
		sprite_index = Juan_Air_attack_up
	}else if key_down{
		sprite_index = Juan_Air_attack
		dir = 0
	}else if key_right{
		dir = 90
		sprite_index = Juan_Air_attack_side
	}else if key_left or image_xscale = -1{
		dir = 270
		sprite_index = Juan_Air_attack_side
	}else{
		sprite_index = Juan_Air_attack_side
		dir = 90
	}
	with (instance_create_layer(x, y, "Instances", hitbox_object)){
		owner = other.id
		target = Tijereta
		image_angle = dir
		sprite_index = Juan_hitbox_air_attack
		image_xscale = other.image_xscale
						
	}
	state = stateAirAttack
}
	
stateFree = function(){ // caninar y caer
	Aplicar_gravedad();
	if directionx != 0{ //moverse en x
		image_xscale = directionx
		if is_on_floor {
			sprite_index = Juan_walk
			vel_x = floor_SPEED*directionx
			if place_meeting(x+directionx, y, Obj_wall) and !place_meeting(x+directionx, y-11, Obj_wall){
					y -= 11
			}
		}
	}else{
		sprite_index = Juan_idle
		if is_on_floor {
			vel_x = lerp(vel_x, 0, 0.2)
		}
	}
	
	if (keyboard_check(vk_space) ){ // a volar

		vel_y = lerp(vel_y, -1, 0.3)
		sprite_index = Juan_fly
		state = stateFly
	}
	
	if mouse_check_button_pressed(1){ // a atacar
		if is_on_floor {
			Attack_1()
		}else{
			Attack_air()
		}
	}
}


stateFly = function(){ //volar
	Aplicar_vuelo();
	if ( keyboard_check(vk_space) ){ //  moverse en y
			vel_y = lerp(vel_y, -1.5, 0.1)
		}
	if directionx != 0{ // moverse en x
		if sign(directionx) == sign(image_xscale){
			sprite_index = Juan_fly_front
		}else{
			sprite_index = Juan_fly_back
		}
		if vel_x != 0{
			image_xscale = sign(vel_x)
		}

		vel_x = lerp(vel_x, air_SPEED*directionx, 0.03)

	
	}else{
		sprite_index = Juan_fly
		vel_x -=  air_friction * sign(vel_x)

	}
	
	if is_on_floor { // vuelve al stateFree
		sprite_index = Juan_idle
		state = stateFree
	}
	
	if mouse_check_button_pressed(1){ // ataque
		Attack_air()
	}
}
	
 stateAttack = function(){ // estos ataque voy a hacer que vuelvan al state free al terminar la animacion nomas
	
	Aplicar_gravedad()
	vel_x = lerp(vel_x, 0, 0.1)
	if place_meeting(x+directionx, y, Obj_wall) and !place_meeting(x+directionx, y-11, Obj_wall){
		y -= 11
	}
	if mouse_check_button_pressed(1){
		if is_on_floor{
			if sprite_index == Juan_attack_1 {
				if image_index > 3{
					vel_x = 3 * directionx
					Attack_2()
				}
			}
			else if sprite_index == Juan_attack_2{
				if image_index > 5{
					Attack_1()
				}
			}else if sprite_index == Juan_Landing_air_attack{
				if image_index > 5{
					Attack_1()
				}
			}else{ // creo que este else esta de mas pero lo dejare porsiacaso
				Attack_1()
			}
		}
	}

}

stateAirAttack = function(){ // Falta hacer que haga el motion input y yaaa
	Aplicar_vuelo()
	if is_on_floor {
		if sprite_index == Juan_Air_attack{
			sprite_index = Juan_Landing_air_attack
			state = stateAttack
		}else if sprite_index == Juan_Air_attack_side{
			if image_index > 2{
				image_index -= 2
			}
			sprite_index = Juan_attack_1
			state = stateAttack
		}
	}
}

stateHit = function(){
	Aplicar_gravedad()
}
state =  stateFree

