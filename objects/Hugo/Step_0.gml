Gravedad();
var correr = (keyboard_check(vk_right) or keyboard_check(ord("D"))) - (keyboard_check(vk_left) or keyboard_check(ord("A")));

if (correr != 0){
	if (place_free(x + correr * 4, y)){
	x += correr * 3;
	}
	
	image_xscale = correr;
	sprite_index = HugoRun;
} else {
	sprite_index = HugoStand;
}

var saltar = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));

if (saltos>0)
	{
		if (saltar)
			{	
				velY = -10;
				saltos--;
			}
	}
suelo = place_meeting(x, y+1, Obj_Tiles) and velY >= 0;
if (suelo == true)
{
saltos = 2;
}

if (!suelo){

if (velY<0){
sprite_index=HugoJump;
}else if (velY>0){
	sprite_index = HugoFall;
}
}
