extends Resource
class_name RandomUtil

class AttackPower:
	const _RATE_V = 0
	const _HIT_MARK = 1
	const _RATE_ATK:float = 2.5
	const _RATE_CRIT_ATK:float = 10.0
	const _NO_DAMAGE_CRIT_MOD = 0.85

	const _MAX_ATK_INC = 0.7
	const _MAX_ATK_DMG_INC = 5

	const _DEFAULT_CRIT = 1.1
	const _MAX_CRIT_ATK_INC = 0.5
	const _MAX_CRIT_ATK_DMG_INC = 3

	var r := RandomNumberGenerator.new()
	var v_min:int
	var v_max:int
	var _ATK_INC = 0
	var _ATK_DMG_INC = 0
	var _CRIT_ATK_DMG_INC = 0
	var _CRIT_ATK_INC = 0

	var damage:int = 0

	func _init(
		_v_min:int,
		_v_max:int
	) -> void:
		r.randomize()
		v_min = _v_min
		v_max = _v_max

	func cap_value(value):
		return max(0, value)

	func attack() -> bool:
		var _v = r.randf_range(_RATE_ATK - cap_value(_ATK_INC), _RATE_V)
		return is_hit(_v)

	func crit() -> bool:
		var _v = r.randf_range(_RATE_CRIT_ATK - cap_value(_CRIT_ATK_INC), _RATE_V)
		return is_hit(_v)

	func atk_damage():
		if !attack():
			return
		var _damge_mod = max(1, cap_value(_ATK_DMG_INC))
		damage = (damage + get_damage()) * _damge_mod

	func no_damage_mod():
		if damage != 0:
			return
		damage = round(v_min * _NO_DAMAGE_CRIT_MOD) + damage

	func crit_damage():
		if crit():
			print("critical")
			no_damage_mod()
			var _crit_mod = _DEFAULT_CRIT + cap_value(_CRIT_ATK_DMG_INC)
			damage = round(damage * _crit_mod)

	func fix_reversed_damage():
		if v_min > v_max:
			v_min = round((v_min - v_max) + 0.5)

	func is_hit(rate:float) -> bool:
		return rate < _HIT_MARK

	func get_damage() -> int:
		fix_reversed_damage()
		var _v = r.randi_range(v_max, v_min)
		return _v

	func calc() -> int:
		atk_damage()
		crit_damage()
		return damage

static func get_attck_power(min_:int, max_:int):
	var p = AttackPower.new(min_, max_)
	return p.calc()

static func get_attack_power_player(player:PlayerObj):
	var _min = 0
	var _max = 0

	return get_attck_power(_min,_max)
