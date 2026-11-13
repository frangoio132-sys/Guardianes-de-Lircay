paused = false
dead = false
won = false

update_pause = function(){
	if paused {
		instance_deactivate_all(true)
		layer_set_visible("Pause_layer", true)
		
	}else{
		instance_activate_all()
		layer_set_visible("Pause_layer", false)
		layer_set_visible("Controls_layer", false)
		
	}
}
update_pause()