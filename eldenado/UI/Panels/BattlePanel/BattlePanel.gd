extends Control

signal battle_start()
signal battle_end()

enum BATTLE_STATUS {
	WIN = 1,
	FAIL = 0,
	FIGHT = -1,
	IDEL = -4
}

onready var inst_monsters := $"%monsters"
onready var logger := $"%battle_log"

const GROUP_BATTLE_MONSTER = "battle_monster"

var monster := preload("res://UI/Components/Monster/monster.tscn")

var player:PlayerObj setget set_player
var monsters:Array = [] setget set_monsters

var battle_state = BATTLE_STATUS.IDEL
var battle_result = {
	"exp":0,
	"gold":0
}

func _process(delta):
	process_battle_result()

func _group_add(mon:Node):
	mon.add_to_group(GROUP_BATTLE_MONSTER)

func monster_group(method_name:String):
	get_tree().call_group(GROUP_BATTLE_MONSTER, method_name)

func set_monsters(_monsters):
	monsters = _monsters
	var mon_size = monsters.size();
	for i in range(mon_size):
		var mon_obj = monsters[i]
		var mon = monster.instance()
		mon.mon = mon_obj
		inst_monsters.add_child(mon)
		_group_add(mon)
	bind_events()
	logger.clear()
	wait_to_palyer()
	emit_battle_start()

func set_player(_player:PlayerObj):
	player = _player

func wait_to_palyer():
	monster_group("wait")

func bind_events():
	Event.connect("player_attack",self,"_on_player_attack")
	var mons := get_tree().get_nodes_in_group(GROUP_BATTLE_MONSTER)
	for o in mons:
		o.connect("spawned",self,"_on_monster_spawned")
		o.connect("on_attack",self,"_on_monster_attack")
		o.connect("dead",self,"_on_monster_dead")
		o.connect("drop",self,"_on_monster_drop")

func _monster_count():
	return inst_monsters.get_child_count()

func process_battle_result():
	if not is_instance_valid(player) || battle_state == BATTLE_STATUS.IDEL:
		return
	var _mon_remains = _monster_count()
	if _mon_remains <= 0:
		battle_state = BATTLE_STATUS.WIN
		emit_battle_end()
	if player.is_dead():
		kill_all_monsters()
		battle_state = BATTLE_STATUS.FAIL
		kill_all_monsters()
		emit_battle_end()

func kill_all_monsters():
	var node_mon = inst_monsters.get_children()
	for mon in node_mon:
		mon.queue_free()

func emit_battle_start():
	battle_state = BATTLE_STATUS.FIGHT
	var text:BattleLogText = logger.format
	text.text = "********战斗开始********"
	logger.println(text)
	emit_signal("battle_start")

func emit_battle_end():
	battle_state = BATTLE_STATUS.IDEL
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

"""
Player Events
"""
func _on_player_attack():
	if battle_state != BATTLE_STATUS.FIGHT:
		return
	monster_group("start")
	var targets = get_random_target()
	for target in targets:
		var player_attack = player.attack()
		var power = player_attack[0]
		var text:BattleLogText = logger.format
		text.text = "你对{0}造成{1}点伤害".format([
			target.stat.name,
			power
		])
		logger.println(text)
		target.take_damage(power)

func get_random_target():
	var node_mon = inst_monsters.get_children()
	var alive_mons:Array = []
	for mon in node_mon:
		if not mon.mon.is_dead():
			alive_mons.append(mon)
	var res = RandomUtil.get_items_random(1, alive_mons)
	return res

"""
Monster Events
"""
func _on_monster_spawned():
	pass

func _on_monster_attack(o):
#	monster_group("wait")
	var dmg = int(o.damage);
	if dmg <= 0:
		return
	var name_text:BattleLogText = logger.format
	name_text.text = o.name
	name_text.color = Color.greenyellow
	var damage_text:BattleLogText = logger.format
	damage_text.text = dmg
	damage_text.color = Color.red
	player.take_damage(dmg)
	logger.println("{0}对你造或{1}点伤害".format([name_text.to_string(),damage_text.to_string()]))

func _on_monster_dead(_exp):
	battle_result.exp = _exp + battle_result.exp
	pass

func _on_monster_drop(drops):
	print("monster drop item->",drops)
	pass
