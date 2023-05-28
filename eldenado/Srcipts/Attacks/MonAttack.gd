extends Resource
class_name MonAttack

var cast
var target
var cd:float

func _init() -> void:
	pass

func start():
	if !can_attack():
		return [0, false]
	var mon_stat = cast.mon_stat
	var ap = AttackPower.new(mon_stat.dc, mon_stat.dc_max)
	ap.ATK_RATE = get_chance() * 100.0
	print("[MonAttack]-> ATK_RATE:",ap.ATK_RATE)
	var power = ap.calc()
	var _t:PlayerObj = target
	_t.give_damge(power, Globals.DAMAGE_TYPE.ATTACK)
	return [power, ap.is_crit_damage()]

func get_chance() -> float:
	var mon_stat = cast.mon_stat
	var _ac = mon_stat.ac + mon_stat.ac_max * 1.0
	var _dc = mon_stat.dc + mon_stat.dc_max * 1.0
	var _speed_time:float = mon_stat.atk_speed / 1000.0
	var _level_speed_mod:float = mon_stat.level / mon_stat.atk_speed * 1.0
	var _c2:float = (_speed_time + _level_speed_mod) * 1.0
	var _c1 = _ac / max(1, _dc) * _c2 * 1.0
	return _c1 * 1.0

func calculate_damage(value):
	var mon_stat = cast.mon_stat
	var _v = (value - RandomUtil.between(mon_stat.ac, mon_stat.ac_max))
	if _v < 0:
		_v = 0
	return _v

func can_attack():
	return not cast.is_dead()

func get_log(power, critcle):
	var text:BattleLogText = BattleLogText.new()
	var c:Color = Color.greenyellow
	if critcle:
		c = Color.lightcoral
	var damage_text:BattleLogText = BattleLogText.new().color(c).set_text(power)
	text.text = "{0}对你造成{1}点伤害".format([
		cast.mon_stat.name,
		damage_text.to_string()
	])
	return text
