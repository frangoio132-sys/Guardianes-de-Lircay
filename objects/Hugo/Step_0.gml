Gravedad();
var correr = (keyboard_check(vk_right) or keyboard_check(ord("D"))) - (keyboard_check(vk_left) or keyboard_check(ord("A")));
suelo = place_meeting(x, y+1, Obj_Tiles) and velY >= 0;
if (sprite_index != HugoAttack)
{
	
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

if (suelo == true)
{
saltos = 1;
}

if (!suelo){

if (velY<0){
sprite_index=HugoJump;
}else if (velY>0){
	sprite_index = HugoFall;
}
}
}
if(mouse_check_button(1)){
if correr != 0{
		image_xscale = correr
	}
	correr = 0
	image_index = 0
	sprite_index = HugoAttack
	with (instance_create_layer(x, y, "Instances",hitbox_object)){
		owner = other.id
		targets = other.Enemies
		sprite_index = HugoHitbox
		image_xscale = other.image_xscale
						
	}
}