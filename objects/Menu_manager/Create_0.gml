paused = false
dead = false
won = false
t_saved_positions = ds_list_create()
saved_posx = x
saved_posy = y
Player = 0

Page_image = inst_A1D5957
Page_index = 0
//crear el diario con todas las paginas
Diario = ds_list_create()
ds_list_add(Diario, Diario_page_0, Diario_page_1, Diario_page_2, Diario_page_3)

if instance_exists(Juan){
	Player = instance_find(Juan , 0)
}
if instance_exists(Hugo){
	Player = instance_find(Hugo , 0)
}

next_page = function(){
	if ds_list_size(Player.Pages)-1 > Page_index {
		Page_index++
		Page_image.sprite_index = ds_list_find_value(Diario, ds_list_find_value(Player.Pages, Page_index) )
	}
}

last_page = function(){
	if Page_index > 0 {
		Page_index--
		Page_image.sprite_index = ds_list_find_value(Diario, ds_list_find_value(Player.Pages, Page_index))
	}
}

save = function(xx, yy){
	
	ds_list_clear(t_saved_positions)
	saved_posx = xx
	saved_posy = yy
	for (var i = 0; instance_number(Tijereta) > i;i++){
		ds_list_add(t_saved_positions, {tx : instance_find(Tijereta, i).x, 
										ty : instance_find(Tijereta, i).y})
	}
}

load = function(){
	
	instance_activate_all()
	
	for (var i = 0; instance_number(Tijereta) > i;i++){
		instance_destroy(Tijereta)
		
	}
	instance_deactivate_all(true)
	for (var i = 0; ds_list_size(t_saved_positions)> i;i++){
		with instance_create_layer(ds_list_find_value(t_saved_positions, i).tx, ds_list_find_value(t_saved_positions, i).ty, "Instances", Tijereta) {
			target = other.Player
		}
	}
	
	Player.x = saved_posx
	Player.y = saved_posy
	update_pause()
	
}

update_pause = function(){
	if paused {
		instance_deactivate_all(true)
		layer_set_visible("Pause_layer", true)
		
	}else{
		instance_activate_all()
		layer_set_visible("Pause_layer", false)
		layer_set_visible("Diario_layer", false)
		
	}
}
update_pause()
save(x, y)