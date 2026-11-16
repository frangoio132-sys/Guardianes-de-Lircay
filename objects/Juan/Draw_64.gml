if 50 > distance_to_object(Savep) { // interactuar con el checkpopint y decirle al menumanager que guarde
	draw_text(590, 520, "Press 'E' to save")
	if keyboard_check_pressed(ord("E")){
		Menu_manager.paused = true
		Menu_manager.resting = true
		Menu_manager.save(x, y)
		Menu_manager.update_pause()
	}
}

