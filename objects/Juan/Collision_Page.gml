
P = instance_place(x, y, Page)
if ds_list_find_index(Pages, P.Page_num) == -1 {
	ds_list_add(Pages, P.Page_num)
	
	ds_list_sort(Pages, true)
	
}
instance_destroy(P)
