var rect_vector2:Vector2;
var rect_origin_vector2:Vector2;	
var mouse_pos:Vector2;
	mouse_pos = get_global_mouse_position();
rect_vector2 = mouse_pos - Vector2(rect_global_position.x + X_OFFSET, rect_global_position.y + Y_OFFSET);
	rect_origin_vector2 = mouse_pos - Vector2(rect_global_position.x, rect_global_position.y);