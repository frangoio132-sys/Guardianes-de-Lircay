if sprite_index == Juan_attack_1 or sprite_index == Juan_attack_2 or sprite_index == Juan_Landing_air_attack{
	image_index = 0
	sprite_index = Juan_idle
	state = stateFree
}else if sprite_index == Juan_Air_attack or sprite_index == Juan_Air_attack_side or sprite_index == Juan_Air_attack_up{
	image_index = 0
	sprite_index = Juan_fly
	state = stateFly
}