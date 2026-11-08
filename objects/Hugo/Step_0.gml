var correr = keyboard_check(vk_right) - keyboard_check(vk_left);

if (correr != 0){
	if (place_free(x + correr * 2, y)){
	x += correr * 2;
	}
	
	image_xscale = correr;
	sprite_index = HugoRun;
} else {
	sprite_index = HugoStand;
}