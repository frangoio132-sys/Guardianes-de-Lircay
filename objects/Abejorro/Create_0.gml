
target = Juan
vida = 3
vel_x = 0
vel_y = 0
SPEED = 4
attack_vel = 0
attack_SPEED = 6
attack_cooldown = 90
cooldown_counter = attack_cooldown

if instance_exists(Juan){
	target = instance_find(Juan , 0)
}
if instance_exists(Hugo){
	target = instance_find(Hugo , 0)
}

stateIdle = function(){
	
	//cuando el objetivo esta a 200 de distancia empieza a perseguir
	if 200 > distance_to_object(target){
		state = stateFollow
	}
	
}
stateFollow = function(){
	// si se aleja mucho vuelve al idle
	if distance_to_object(target) > 400{
		state = stateIdle
	}
	
	// girar la imagen
	if sign(target.x-x) != 0{
		image_xscale = sign(target.x-x)
	}
	
	// se acerca al objetivo
	if distance_to_object(target) > 150{
		// aqui solo se acwerta si esta muy lejos del objetivo
		vel_x = lerp(vel_x, SPEED* (target.x-x)/point_distance(x, y, target.x, target.y), 0.05)
		
		vel_y = lerp(vel_y, SPEED* (target.y-y)/point_distance(x, y, target.x, target.y), 0.05)
		
	}else{
		// no se como explicar esto
		// es para que se vaya alineando antes de dar un golpe
		vel_x = lerp(vel_x, -SPEED/1.6*(target.x-x)/point_distance(x, y, target.x, target.y), 0.05)
		vel_y = lerp(vel_y, sign(target.y-y), 0.02)
	}
	if place_free(x+vel_x, y){
		x += vel_x
	}else vel_x = 0
	
	
	if place_free(x, y+vel_y){
		y += vel_y
	}else vel_y = 0
	
	// revisar si esta posicionado para atacar
	cooldown_counter--
	if 10 > abs(y-target.y) and  abs(x-target.x) > 100  and 0 >= cooldown_counter{
		// atacar
		cooldown_counter = attack_cooldown
		image_index = 0
		sprite_index = bumblebee_attack
		attack_vel = attack_SPEED* sign(target.x-x)
		with (instance_create_layer(x, y, "Instances", hitbox_object)){
			owner = other.id
			ds_list_add(targets, other.target)
			sprite_index = bumblebee_attack_hitbox
			image_xscale = other.image_xscale
						
		}
		state = stateAttack
	}
	
}

stateAttack = function(){
	vel_x = lerp(vel_x, attack_vel, 0.06)
	vel_y = lerp(vel_y, sign(target.y-y), 0.02)
	if place_free(x+vel_x, y){
		x += vel_x
	}else vel_x = 0
	
	
	if place_free(x, y+vel_y){
		y += vel_y
	}else vel_y = 0
	
}

stateHit = function(){
	if !place_meeting(x+vel_x, y, Obj_wall){
		x += vel_x	
	}
	if !place_meeting(x+vel_y, y, Obj_wall){
		y += vel_y
	}
	vel_x = lerp(vel_x, 0, 0.1)
	vel_y = lerp(vel_y, 0, 0.1)
	
}
Get_Hit = function(){
	alarm_set(0, 15)
	vida--
	image_index = 0
	sprite_index = bumblebee
	if (0  >= vida ){
		instance_destroy()
	}
	state = stateHit
}

state = stateIdle