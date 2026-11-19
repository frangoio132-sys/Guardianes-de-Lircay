
switch button_id{
	case 0: // resume
        Menu_manager.paused = false
        Menu_manager.update_pause()
		break;
	case 1: // back to pause menu
		layer_set_visible("Pause_layer", true)
		layer_set_visible("Diario_layer", false)
		break;
	case 2: // boton paraw ver el diario
		layer_set_visible("Pause_layer", false)
		layer_set_visible("Diario_layer", true)
		break;
	case 3: // load button
		Menu_manager.load()
		break;
	case 4: //siguiente pagina
		Menu_manager.next_page()
		break;
	case 5: //pagina anterior
		Menu_manager.last_page()
		break;
}