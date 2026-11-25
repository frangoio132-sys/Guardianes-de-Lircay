
var cam = view_get_camera(0)
pos_x = (camera_get_view_x(cam) - 1500)/3000
pos_y = (camera_get_view_y(cam) - 2200)/3000


layer_x("Nubes", pos_x * 500)

layer_x("B1", pos_x * 30)
layer_y("B1", pos_y * 30)

layer_x("B2", pos_x * 60)
layer_y("B2", pos_y * 60)

layer_x("B3", pos_x * 90)
layer_y("B3", pos_y * 90)

layer_x("B4", pos_x * 120)
layer_y("B4", pos_y * 120)

layer_x("B5", pos_x * 150)
layer_y("B5", pos_y * 150)

layer_x("B6", pos_x * 1000)


