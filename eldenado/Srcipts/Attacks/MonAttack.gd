extends AttackBase

func calculate_coming_damage(value):
	var mon_stat = target.mon_stat
	var _v = (value - RandomUtil.between(mon_stat.ac, mon_stat.ac_max))
	if _v < 0:
		_v = 0
	return _v

func hit():
	var _c1:float = get_chance()
	var chance = RandomUtil.get_random_digit(_c1)
	return chance > 0

func take_damge(value):
	target.mon_stat.hp = target.mon_stat.hp - calculate_coming_damage(value)

func attack():
	if cast.is_dead():
		return -1
	if not cast.hit():
		return 0
	return get_power()

func get_power():
	var _r = RandomNumberGenerator.new()
	_r.randomize()
	var n = _r.randi_range(target.mon_stat.dc,target.mon_stat.dc_max)

	return n

func get_chance() -> float:
	var mon_stat = target.mon_stat
	var _ac = mon_stat.ac + mon_stat.ac_max * 1.0
	var _dc = mon_stat.dc + mon_stat.dc_max * 1.0
	var _speed_time:float = mon_stat.atk_speed / 1000.0
	var _level_speed_mod:float = mon_stat.level / mon_stat.atk_speed * 1.0
	var _c2:float = (_speed_time + _level_speed_mod) * 1.0
	var _c1 = _ac / max(1, _dc) * _c2 * 1.0
	return _c1 * 1.0
