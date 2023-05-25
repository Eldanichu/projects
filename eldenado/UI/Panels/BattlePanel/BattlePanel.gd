extends Control
class_name BattlePanel

signal battle_start()
signal battle_end()

const BATTLE_STATUS = Globals.BATTLE_STATUS

onready var inst_monsters := $"%monsters"
onready var logger := $"%battle_log"
onready var anim := $"%fade_out"

const GROUP_BATTLE_MONSTER = "battle_monster"

var pkg_monster := preload("res://UI/Components/Monster/monster.tscn")

var player:PlayerObj setget set_player
var mon_objs:Array = [] setget set_monsters

var battle_state = BATTLE_STATUS.WAIT
var battle_result = {
	"exp":0,
	"gold":0
}

func _ready() -> void:
		Event.connect("player_attack",self,"_on_player_attack")

func _process(delta):
	process_battle_result()

func _group_add(mon:Node):
	mon.add_to_group(GROUP_BATTLE_MONSTER)

func monster_group(method_name:String):
	get_tree().call_group(GROUP_BATTLE_MONSTER, method_name)

func set_monsters(_mon_obj:Array):
	mon_objs = _mon_obj
	var mon_objs_size = mon_objs.size();
	for i in range(mon_objs_size):
		var mon_obj = mon_objs[i]
		var pkg_mon = pkg_monster.instance()
		pkg_mon.mon_obj = mon_obj
		inst_monsters.add_child(pkg_mon)
		_group_add(pkg_mon)
	logger.clear()
	wait_to_palyer()
	bind_events()
	emit_battle_start()

func set_player(_player:PlayerObj):
	player = _player

func wait_to_palyer():
	monster_group("wait")
	yield(get_tree().create_timer(0.5),"timeout")
	monster_group("starts_battle")
	pass

func bind_events():
	var mons := get_tree().get_nodes_in_group(GROUP_BATTLE_MONSTER)
	for o in mons:
		o.connect("spawned",self,"_on_monster_spawned")
		o.connect("on_attack",self,"_on_monster_attack")
		o.connect("dead",self,"_on_monster_dead")
		o.connect("drop",self,"_on_monster_drop")

func _monster_count():
	return inst_monsters.get_child_count()

func process_battle_result():
	if not is_instance_valid(player) || battle_state == BATTLE_STATUS.WAIT:
		return
	var _mon_remains = _monster_count()
	if _mon_remains <= 0:
		battle_state = BATTLE_STATUS.WIN
		emit_battle_end()

func kill_all_monsters():
	var node_mon = inst_monsters.get_children()
	for mon in node_mon:
		mon.queue_free()

func reset_battle_result():
	battle_result = {
	"exp":0,
	"gold":0
}

func emit_battle_start():
	modulate.a = 1
	battle_state = BATTLE_STATUS.FIGHT
	var text:BattleLogText = logger.format
	text.text = "********战斗开始********"
	logger.println(text)
	emit_signal("battle_start")

func emit_battle_end():
	battle_state = BATTLE_STATUS.WAIT
	var text:BattleLogText = logger.format
	text.text = "********战斗结束********"
	logger.println(text)
	var result_text = logger.format
	result_text.text = "金币{gold}\n经验值{exp}点".format({
		"gold":battle_result.gold,
		"exp":logger.format.color(Color.green).set_text(battle_result.exp).to_string(),
	})
	player.give_exp(battle_result.exp)
	logger.println(result_text)
	anim.play("battle_end")
	yield(anim,"animation_finished")
	reset_battle_result()
	emit_signal("battle_end")

"""
Player Events
"""
func _on_player_attack(slot_obj:Dictionary):
	if battle_state != BATTLE_STATUS.FIGHT || player.is_dead():
		return
	print("[battle_panel]->",slot_obj)
	var attack := DefaultAttack.new()
	var mon = get_selected_target()
	if !mon:
		mon = get_random_target()[0]
	attack.cast = player
	if !mon || mon == null:
		return
	attack.target = mon.mon_obj
	var v:Array = attack.start()
	var power:int = v[0]
	var is_critcle:bool = v[1]
	var text = attack.get_log(power,is_critcle)
	logger.println(text)

func get_selected_target():
	var monsters = inst_monsters.get_children()
	var _monster = null
	for mon in monsters:
		if mon.hover:
			_monster = mon
	return _monster

func get_random_target():
	var node_mon = inst_monsters.get_children()
	var alive_mons:Array = []
	for node in node_mon:
		if not node.mon_obj.is_dead():
			alive_mons.append(node)
	var res = RandomUtil.get_items_random(1, alive_mons)
	return res

"""
Monster Events
"""
func _on_monster_spawned():
	pass

func _on_monster_attack(mon_obj:MonObj):
	if mon_obj.is_dead():
		return
	var attack := MonAttack.new()
	attack.cast = mon_obj as MonObj
	attack.target = player as PlayerObj
	var v:Array = attack.start()
	var power:int = v[0]
	var is_critcle:bool = v[1]
	var text = attack.get_log(power,is_critcle)
	logger.println(text)

#	logger.println("{0}对你造或{1}点伤害".format([name_text.to_string(),damage_text.to_string()]))

func _on_monster_dead(_exp):
	battle_result.exp = _exp + battle_result.exp
	pass

func _on_monster_drop(drops):
	print("monster drop item->",drops)
	pass
