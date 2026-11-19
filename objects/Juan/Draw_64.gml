if state == stateFree {
	
	if 50 > distance_to_object(Savep) { // interactuar con el checkpopint y decirle al menumanager que guarde
		draw_text(590, 520, "Press 'E' to save")
		if keyboard_check_pressed(ord("E")){
			Menu_manager.save(x, y)
		}
	}else if 50 > distance_to_object(misterios){
		instance_nearest(x, y, misterios).near()
		
	}

}
