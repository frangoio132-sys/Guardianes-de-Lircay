Gravedad();
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

var saltar = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));

if (saltar)
	{	
		velY = -10;
	}
	
