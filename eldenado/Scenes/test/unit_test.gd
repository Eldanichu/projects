extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = ATimer.new(self)

onready var p = $polygon_2d

var chances:Array = []
var player := PlayerObj.new()
var r := RandomNumberGenerator.new()

var mouse_position:Vector2 = Vector2.ZERO
var points:PoolVector2Array = []

func _ready():
	r.randomize()
	combat_log.clear()
#	p.rotate(deg2rad(45))

func poly_rect(position:Vector2) -> PoolVector2Array:
	var size = 100
	var offset = -(size * 0.5)
	position = position - Vector2(size + offset, size + offset)
	var polygon = PoolVector2Array([
		Vector2(position.x, position.y),
		Vector2(position.x + size, position.y),
		Vector2(position.x + size, position.y + size),
		Vector2(position.x, position.y + size),
		Vector2(position.x, position.y),
	])
	return polygon

func check_points():
	for i in range(points.size()):
		var is_in_c = Geometry.is_point_in_circle(mouse_position,points[i], 5)
		var c = Color.yellow
		if is_in_c:
			c = Color.red
		draw_circle(points[i], 5, c)

func _input(event:InputEvent):
	if event as InputEventMouseMotion:
		mouse_position = event.position
		p.position = mouse_position
#	if event as InputEventMouseButton:
#		if event.button_index == 4:
#			p.scale = p.scale - Vector2(0.1,0.1)
#		elif event.button_index == 5:
#			p.scale = p.scale + Vector2(0.1,0.1)

#	if event as InputEventMouseButton:
#		if event.is_pressed() && event.button_index == 1:
#			points.append(Vector2(event.position))
	update()

func _draw() -> void:
	var tv:PoolVector2Array = ShapeUtil.get_polygon2D_points(p)
	draw_polyline_colors(tv,[Color.white],1)
#	draw_polyline_colors(poly_rect(mouse_position),PoolColorArray([Color.white]),1)
#	draw_string(load("res://Assets/Fonts/res/chn-14.tres"),Vector2(300,600),str(points))
#	draw_polygon(points,[Color.white])

func _on_Add_Timer_pressed() -> void:
	timer.Interval = 2
	timer.connect("remains",self,"_timer_remaining")
	timer.start_timer()
	pass

func _on_reduce_pressed() -> void:
		pass

func _on_Restart_Timer_pressed() -> void:
	timer.resume()
	pass

func _timer_remaining(s):
	combat_log.println(str(s))

func _on_pause_timer_pressed() -> void:
	timer.pause()

func _on_append_item_pressed():
	pass

func _on_roll_item_pressed():
	pass


func _on_RandomTest_pressed():
	chances = []
	var crit_chance = 32.0
	var crit_chance_max = 80.0
	var p = min(crit_chance / crit_chance_max * 100, crit_chance_max)
	var c = (p / 100.0) * 100

	var hit_times = 100
	for i in range(hit_times):
		var n = r.randf() * 100 + 1
		var hit = n < c
		if hit:
			chances.append(1)
		else:
			chances.append(0)

	var total = chances.size() * 1.0
	var hits = 0
	var miss = 0
	for i in chances:
		if i == 1:
			hits = hits + 1
		elif i == 0:
			miss = miss + 1

	var hit_chance = (hits * 1.0) / total * 100
	var miss_chance = (miss * 1.0) / total * 100
	var text = combat_log.format
	text.text = "{0}times, hit chance-> {1}%\t".format([hit_times, hit_chance])
	text.text = "{0}miss chance-> {1}%".format([text.text, miss_chance])
	combat_log.println(text)


func _on_CharecterTest_pressed():
	player.set_stat({
		"dc":2,
		"dc_max":5
	})
	var attack = player.attack()
	var crit_attack = attack[1]
	var dmg = attack[0]

	var dmg_text = combat_log.format
	if crit_attack:
		var color = Color.green
		color.a = 0.5
		dmg_text.color = color
		dmg_text.b
	dmg_text.text = dmg
	combat_log.println(dmg_text)


func _on_AddNewMemberForClassTest_pressed() -> void:
	var slot := SlotObject.new()
	slot.id = "1"
	slot.type = 1
	slot.icon = "222"
	print(slot.to_object())

	pass # Replace with function body.
