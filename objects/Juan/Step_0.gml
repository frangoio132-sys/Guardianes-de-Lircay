
key_right =  (keyboard_check(vk_right) or keyboard_check(ord("D")))
key_left  =  (keyboard_check(vk_left) or keyboard_check(ord("A")))

directionx = key_right - key_left

key_up =  (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(vk_space))
key_down  =  (keyboard_check(vk_down) or keyboard_check(ord("S")))

is_on_floor = place_meeting(x, y+1, Obj_wall) and vel_y >= 0

directiony = key_down - key_up


// cuando termine el state machine aqui ira todo lo que dabe correse siempre
	// gravedad, recibir daño, colisiones
if mouse_check_button_pressed(1) and is_on_floor{
	if sprite_index == Juan_attack_1 {
		if image_index > 3{
			vel_x = 3 * directionx
			if directionx != 0{
				image_xscale = directionx
			}
			directionx = 0
			image_index = 0
			sprite_index = Juan_attack_2
		}
	}
	else if sprite_index == Juan_attack_2{
		if image_index > 5{
			if directionx != 0{
				image_xscale = directionx
			}
			directionx = 0
			image_index = 0
			sprite_index = Juan_attack_1
		}
	}
	else{
		directionx = 0
		image_index = 0
		sprite_index = Juan_attack_1
	}
	is_attacking = true
	
}


// aplicar la velocidad en x (lerp es para el que movimiento sea mas suave)

// correr y caminar
if directionx != 0 and !is_attacking {
	if vel_x != 0{
		image_xscale = sign(vel_x)
	}
	if is_on_floor {
		sprite_index = Juan_walk
		vel_x = floor_SPEED*directionx
		if place_meeting(x+directionx, y, Obj_wall) and !place_meeting(x+directionx, y-11, Obj_wall){
			y -= 11
		}
	}else{
		vel_x = lerp(vel_x, air_SPEED*directionx, 0.03)
	}
	
}else{
	if is_on_floor {
		if is_attacking{
			vel_x = lerp(vel_x, 0, 0.1)
		}else{
			vel_x = 0
		}
		
	}else{
		vel_x -=  air_friction * sign(vel_x)
	}
}


//este if detecta si esque el personaje va a colisionar con un "wall" en el siguiente frame (solo en el eje y)
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
		if flying{
			vel_y = lerp(vel_y, 0.5, 0.1)
		}
		else{
			vel_y += gravedad
		}
	}
	
}

// aqui todo lo que es volar - añadir limite de vuelo
if ( keyboard_check(vk_space)  and !is_attacking){
	vel_y = lerp(vel_y, -1.5, 0.1)
	sprite_index = Juan_fly
	flying = true
}

if is_on_floor {
	flying = false
	if !is_attacking and directionx == 0{
		image_index = 0
		sprite_index = Juan_idle
	}
}

move_and_collide(vel_x, 0, Obj_wall) // esta cosa solo actualiza el movimiento en el eje x




