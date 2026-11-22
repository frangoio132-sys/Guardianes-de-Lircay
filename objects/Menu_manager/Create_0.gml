paused = false
dead = false
won = false
t_saved_positions = ds_list_create()
a_saved_positions = ds_list_create()
saved_posx = x
saved_posy = y
saved_health = 5
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
	
	saved_posx = xx
	saved_posy = yy
	saved_health = Player.vida
	ds_list_clear(t_saved_positions)
	for (var i = 0; instance_number(Tijereta) > i;i++){
		ds_list_add(t_saved_positions, {tx : instance_find(Tijereta, i).x, 
										ty : instance_find(Tijereta, i).y})
	}
	ds_list_clear(a_saved_positions)
	for (var i = 0; instance_number(Abejorro) > i;i++){
		ds_list_add(a_saved_positions, {tx : instance_find(Abejorro, i).x, 
										ty : instance_find(Abejorro, i).y})
	}
	
}

load = function(){
	
	// elimina todas las tijeretas y avejorros
	instance_activate_all()
	for (var i = 0; instance_number(Tijereta) > i;i++){
		instance_destroy(Tijereta)
	}
	for (var i = 0; instance_number(Abejorro) > i;i++){
		instance_destroy(Abejorro)
	}
	instance_deactivate_all(true)
	
	// reaparece al tijeretas y avejorros en sus pociciones guardadas
	for (var i = 0; ds_list_size(t_saved_positions)> i;i++){
		with instance_create_layer(ds_list_find_value(t_saved_positions, i).tx, ds_list_find_value(t_saved_positions, i).ty, "Instances", Tijereta) {
			target = other.Player
		}
	}
	for (var i = 0; ds_list_size(a_saved_positions)> i;i++){
		with instance_create_layer(ds_list_find_value(a_saved_positions, i).tx, ds_list_find_value(a_saved_positions, i).ty, "Instances", Abejorro) {
			target = other.Player
		}
	}
	
	Player.x = saved_posx
	Player.y = saved_posy
	Player.vida = saved_health
	if Player.object_index == Juan{
		Player.state = Player.stateFree
	}
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