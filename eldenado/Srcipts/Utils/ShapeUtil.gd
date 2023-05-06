extends Reference
class_name ShapeUtil

static func get_polygon2D_points(polygon:Polygon2D):
	var transform = polygon.get_transform();
	var points:PoolVector2Array = transform.xform(polygon.polygon)
	var last_line = PoolVector2Array([
		points[-1],
		points[0]
	])
	points.append_array(last_line)

	return points
