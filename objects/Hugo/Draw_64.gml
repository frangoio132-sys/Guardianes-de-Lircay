if sprite_index==HugoStand {
	
	if 50 > distance_to_object(Savep) { // interactuar con el checkpopint y decirle al menumanager que guarde
		draw_text(800, 550, "Presiona E para Guardar")
		if keyboard_check_pressed(ord("E")) and vida > 0{
			Menu_manager.save(x, y)
		}
	}else if 50 > distance_to_object(misterios){
		instance_nearest(x, y, misterios).near()
		
	}

}

for (var  i = 0; i < vida_max;i++){
	if i < vida {
	
		draw_sprite(FrogLive, 1, 60 + i*60, 50)
	}
	else{
		draw_sprite(FrogDead, 0, 60 + i*60, 50)
	}
	
}
