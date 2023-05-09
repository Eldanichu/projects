extends Control

onready var inst_monsters := $"%monsters"
onready var logger := $"%battle_log"

const GROUP_BATTLE_MONSTER = "battle_monster"

var monster := preload("res://UI/Components/Monster/monster.tscn")
var monsters:Array = [] setget set_monsters

func _ready() -> void:
	logger.clear()

func _group_add(mon:Node):
	mon.add_to_group(GROUP_BATTLE_MONSTER)

func _group_call(method_name:String):
	get_tree().call_group(GROUP_BATTLE_MONSTER, method_name)

func set_monsters(_monsters):
	var mon_size = _monsters.size();
	for i in range(mon_size):
		var mon_obj = _monsters[i]
		var mon = monster.instance()
		mon.mon = mon_obj
		inst_monsters.add_child(mon)
		_group_add(mon)
	bind_events()
	wait_to_palyer()

func wait_to_palyer():
	_group_call("wait")
	_group_call("start")

func bind_events():
	var mons := get_tree().get_nodes_in_group(GROUP_BATTLE_MONSTER)
	for o in mons:
		o.connect("spawned",self,"_on_spawned")
		o.connect("on_attack",self,"_on_attack")
		o.connect("dead",self,"_on_dead")
		o.connect("drop",self,"_drop")

func _on_spawned():
	pass

func _on_attack(o):
	var dmg = int(o.damage);
	if dmg <= 0:
		return
	var name_text:BattleLogText = logger.format
	name_text.text = o.name
	name_text.color = Color.greenyellow
	var damage_text:BattleLogText = logger.format
	damage_text.text = dmg
	damage_text.color = Color.red

	logger.println("{0}对你造或{1}点伤害".format([name_text.to_string(),damage_text.to_string()]))


func _on_dead():
	pass

func _drop(drops):
	pass
#	var _mons = inst_monsters.get_children()
#	for mon_tscn in _mons:
#		mon_tscn.wait()
