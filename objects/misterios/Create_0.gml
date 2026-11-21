
dialogue = ds_list_create()
saying = ""
ds_list_add(dialogue, "hola", "ppppp ppppppp pppppppppp pppppppppp ppppppp pppppss ssssss sssss sssssssssss sssssss", "aaaaaaaaaa")
dialogue_i = -1 
letter_i = 1


near = function(){
	
	// poner aqui la vista que esta activa en la room
	cam = view_get_camera(0)
	
	// proporcion vista/camara
	// muy importante que la proporcion este correcta
	P = 1.6
	
	if dialogue_i == -1{

		draw_text((x - camera_get_view_x(cam))*P , (y - camera_get_view_y(cam))*P, "E")
		if keyboard_check_pressed(ord("E")){
			dialogue_i++
		}
	}else{
		//esta linea es la mas importante
		// falta dibujar algo para que se vea  bonito
		var text_pos = min(210, string_length(ds_list_find_value(dialogue, dialogue_i))*9)
		draw_text_ext((x - camera_get_view_x(cam))*P - text_pos , (y - camera_get_view_y(cam))*P - 40, saying, 20, 210)
		
		if string_length(ds_list_find_value(dialogue, dialogue_i)) >= letter_i{
			saying += string_char_at(ds_list_find_value(dialogue, dialogue_i), letter_i)
			
			letter_i++
			if keyboard_check_pressed(ord("E")) {
				letter_i = string_length(ds_list_find_value(dialogue, dialogue_i)) + 1
				saying = ds_list_find_value(dialogue, dialogue_i)
			}
		}else{
			if keyboard_check_pressed(ord("E")) {
				saying = ""
				letter_i = 1
				if ds_list_size(dialogue)- 1 > dialogue_i {
					dialogue_i++
				}else {dialogue_i = -1}
			}
		}
	}
	
}