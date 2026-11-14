grav = 0.4;
velY = 0.0
maxVely = 15;

Gravedad = function(){
	 if place_meeting(x, y+velY, Obj_Tiles) { 
	
		while (!place_meeting(x, y+sign(velY), Obj_Tiles)){
			y+= sign(velY)
		}
		velY = 0
	}else{
	
		y += velY
		if maxVely > velY{ 
			velY += grav;
		}
	
	}
}