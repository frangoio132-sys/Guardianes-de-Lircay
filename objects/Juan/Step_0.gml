
key_right =  (keyboard_check(vk_right) or keyboard_check(ord("D")))
key_left  =  (keyboard_check(vk_left) or keyboard_check(ord("A")))

directionx = key_right - key_left

key_up =  (keyboard_check(vk_up) or keyboard_check(ord("W")))
key_down  =  (keyboard_check(vk_down) or keyboard_check(ord("S")))

is_on_floor = place_meeting(x, y+1, Obj_wall) and vel_y >= 0

directiony = key_down - key_up


// cuando termine el state machine aqui ira todo lo que dabe correse siempre

state();

// gravedad, recibir daño, colisiones


//este if detecta si esque el personaje va a colisionar con un "wall" en el siguiente frame (solo en el eje y)



move_and_collide(vel_x, 0, Obj_wall) // esta cosa solo actualiza el movimiento en el eje x



