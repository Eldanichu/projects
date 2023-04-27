extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = ATimer.new(self)

var chances:Array = []
var player := PlayerObj.new()
var r := RandomNumberGenerator.new()

func _ready():
	combat_log.clear()
	pass

func _input(event):
	if event as InputEventMouseButton:
		if event.is_pressed():
			pass

func _draw() -> void:

	update()
	pass

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
	combat_log.println_code_string(str(s))

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
		r.randomize()
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
