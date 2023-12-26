extends RefCounted
class_name BattleCounter

var mons:Array[MonsterScene] = []
var mons_mask:Dictionary = {}
var current = -1
var total = 0

func _init():
	reset()

func add(mon_scene:MonsterScene):
	mons.append(mon_scene)
	var mon_name = mon_scene.name
	mons_mask[mon_name] = 1
	update_total()

func remove(mon_scene_name:String):
	print("[BattleCounter] remove->",mon_scene_name)
	var index = 0
	var mon_name
	for ms in mons:
		mon_name = ms.name
		if mon_scene_name == mon_name:
			mons_mask[mon_name] = 0
		index += 1

func remove_all():
	var len = len(mons) - 1
	var ms
	for i in range(len,-1,-1):
		ms = mons[i] as MonsterScene
		mons.remove_at(i)
		ms.queue_free()
	reset()

func get_target() -> MonObject:
	if not has_target():
		return null
	return get_current().mon_obj

func has_target() -> bool:
	var _cur := get_current()
	var _obj = _cur.mon_obj
	if not _cur:
		return false
	if _obj.is_dead():
		return false
	return true

func get_current() -> MonsterScene:
	if mons.is_empty():
		return null
	if current == -1:
		current = 0
	var _cur = mons[current] as MonsterScene
	
	return _cur

func reset():
	current = -1
	total = 0

func next():
	if is_battle_end():
		remove_all()
		return
	if not has_target():
		current += 1
	get_current().auto_attack()

func has_next() -> bool:
	var _max = total - 1
	if current >= _max:
		current = _max
		return false
	return true

func update_total():
	total = len(mons)

func is_battle_end():
	var ended = true
	for key in mons_mask:
		if mons_mask[key] != 0:
			ended = false
	return ended
