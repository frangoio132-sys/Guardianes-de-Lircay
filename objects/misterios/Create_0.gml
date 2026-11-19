
dialogue = ds_list_create()
saying = ""
ds_list_add(dialogue, "hola", "ppppp ppppppp pppppppppp pppppppppp ppppppp  ppppp ppppp pppppppppppp pppppss ssssss sssss sssssssssss sssssss ssssssss", "aaaaaaaaaa")
dialogue_i = -1 
letter_i = 1


near = function(){
	
	if dialogue_i == -1{

		draw_text(260 + x - camera_get_view_x(view_get_camera(0)) , 50 + y - camera_get_view_y(view_get_camera(0)), "E")
		if keyboard_check_pressed(ord("E")){
			dialogue_i++
		}
	}else{
		//esta linea es la mas importante
		// falta dibujar algo para que se vea  bonito
		var text_pos = 210 - min(210, string_length(ds_list_find_value(dialogue, dialogue_i))*9)
		draw_text_ext(text_pos + x - camera_get_view_x(view_get_camera(0)) , 20 + y - camera_get_view_y(view_get_camera(0)), saying, 20, 210)
		
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