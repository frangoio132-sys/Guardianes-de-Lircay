

gravedad = 0.4
vel_y = 0.0
max_vel_y = 15
vel_x = 0
floor_friction = 1
air_friction  = 0.01
air_SPEED = 9
floor_SPEED = 2

key_right =  (keyboard_check(vk_right) or keyboard_check(ord("D")))
key_left  =  (keyboard_check(vk_left) or keyboard_check(ord("A")))

directionx = key_right - key_left

key_up =  (keyboard_check(vk_up) or keyboard_check(ord("W")) or keyboard_check(vk_space))
key_down  =  (keyboard_check(vk_down) or keyboard_check(ord("S")))

is_on_floor = place_meeting(x, y+1, Obj_wall) and vel_y >= 0

directiony = key_down - key_up

flying = false

is_attacking = false
