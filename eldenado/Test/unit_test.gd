extends Control

onready var combat_log = get_node("%combat_log")
onready var timer = AdjustableTimer.new(self)

var gct := CombatTextFormatter.new()
var ItemsDB = load("res://DB/ItemDB.gd").new()

var rand_gen := RandomNumberGenerator.new()
var loot := LootTable.new()

func _ready():
	rand_gen.randomize()

func _exit_tree() -> void:
	gct.queue_free();

func _input(event):
	if event as InputEventMouseButton:
		if event.is_pressed():
			pass

func _on_append_text_pressed() -> void:
	var combat_text := CombatTextFormatter.new()
	combat_text.set_formatter(CombatTextFormatter.LogType.MAKE_DAMAGE)
	combat_text.set_text_kv("Monster","32")
	combat_log.println_code_string(combat_text.get_string())
	combat_text.queue_free()


func _on_Add_Timer_pressed() -> void:
	timer.timer_id = 'myTimer-1'
	timer.connect("remains",self,"_on_timer_remaining")
	timer.connect("timeout",self,"_on_timer_remaining")
	timer.start_timer()

func _on_timer_remaining(remains):
	gct.set_formatter(CombatTextFormatter.LogType.SKILL_COOLDOWN)
	gct.set_text(str(remains))
	combat_log.println_code_string(gct.get_string())


func _on_reduce_pressed() -> void:
	var amount = float(get_node("%amount").text)
	timer.reduce_amount(amount,"%")


func _on_Start_Timer_pressed() -> void:
	timer.restart()

func _on_append_item_pressed():
	for i in range(0,9):
		var _item := LootItem.new()
		var __ritem = _get_random_item()
		_item._name = __ritem[0]
		_item._pty = __ritem[1]
		_item._tc = __ritem[2]
		_item._rv = __ritem[3]
		loot.add(_item)
	combat_log.append_bbcode(loot.get_items_result())

func _get_random_item():
	var inames = ItemsDB.Items
	var _item_index = rand_gen.randi_range(0, inames.size() - 1)
	var _random_item = inames[_item_index]
	return _random_item

func _on_roll_item_pressed():
	var items = loot.roll(1)
	var result = loot.get_rolled_result(items)
	combat_log.append_bbcode(result)

