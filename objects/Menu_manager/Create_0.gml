paused = false
dead = false
won = false
resting = false
saved_posx = x
saved_posy = y

// por ahora solo guada la posicion del personaje
save = function(xx, yy){
	saved_posx = xx
	saved_posy = yy

}

update_pause = function(){
	if paused {
		instance_deactivate_all(true)
		if resting{
			layer_set_visible("Savepoint_Layer", true)
		}else{
			layer_set_visible("Pause_layer", true)
		}
		
	}else{
		instance_activate_all()
		layer_set_visible("Pause_layer", false)
		layer_set_visible("Savepoint_layer", false)
		
	}
}
update_pause()