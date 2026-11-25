
dialogue = ds_list_create()
saying = ""

dialogue_i = -1 
letter_i = 1

if instance_exists(Juan){
	ds_list_add(dialogue, "Oh? ", "no esperaba ver a una criatura como tu salir de ese agujero", "y veo que has encontrado las paginas que habia perdido", "MHAHA, ya veo porque dicen que ustedes traen buena suerte", "Hmm? te interesa lo que hay en esas viejas hojas?", "puedes quedartelas si quieres, talvez encuentres mas por ahi tiradas")
}
if instance_exists(Hugo){
	// aqui poner el dialogo que le va a decir a hugo
	ds_list_add(dialogue, "vaya, ", "ppppp ppppppp pppppppppp pppppppppp ppppppp pppppss ssssss sssss sssssssssss sssssss", "aaaaaaaaaa aaaa aaaa aaaa aaa")
}

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
		
		current_phrase = ds_list_find_value(dialogue, dialogue_i)
		var text_width = min(210, string_length(current_phrase)*9)
		var text_heigth = ceil(string_length(current_phrase)*9/210)*30
		var final_pos_x = (x - camera_get_view_x(cam))*P - text_width
		var final_pos_y = (y - camera_get_view_y(cam))*P - 30 + 120 - text_heigth
		
		
		
		draw_sprite_stretched(dialogue_bubble_sprite, 1, final_pos_x-5, final_pos_y, text_width + 32, text_heigth + 10)
		draw_text_ext( final_pos_x , final_pos_y, saying, 20, 210)
		
		if string_length(current_phrase) >= letter_i{
			saying += string_char_at(current_phrase, letter_i)
			
			letter_i++
			if keyboard_check_pressed(ord("E")) {
				letter_i = string_length(current_phrase) + 1
				saying = current_phrase
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