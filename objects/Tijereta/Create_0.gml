vida = 3

gravedad = 0.4
vel_y = 0.0
max_vel_y = 15
vel_x = 0
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
}
stateRoam = function(){
	Aplicar_gravedad()
	
}

Get_Hit = function(stunFrames, hitter){
	if (stunFrames  > 0){
		stunFrames = 0
	}
	alarm_set(0, stunFrames)
	state = stateHit
}

state = stateRoam