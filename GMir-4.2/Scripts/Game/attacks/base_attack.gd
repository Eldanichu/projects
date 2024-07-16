extends RefCounted
class_name BaseAttack

var rnd = RandomEx.get_instance()
var _source:GameObject

func _init(source:GameObject):
	_source = source

func melee_attack(target:GameObject):
	var chance = _source.properties.ar
	var hit = rnd.chance(chance)
	if not hit:
		return
	if not target.has_method("update_ui"):
		return
	var dmg = calculate_damage(target)
	var vt:ValueTick = ValueTick.new(target)
	vt.TKey = "hp"
	vt.TValue = dmg
	vt.set_tick_type(vt.TICK_TYPE.NUMBER)
	vt.set_tick_action(vt.TICK_ACTION.MINUS)
	vt.set_max_value(target.properties.hp_max)
	vt.proc()
	target.update_ui()


func calculate_damage(target:GameObject):
	var _src = _source.properties
	var _tar = target.properties
	var dc = _src.dc
	var dcc = _src.dcc
	var agi = _src.agi
	var t_ac = _tar.ac
	var t_dr = _tar.dr
	var d = rnd.rand_i_range(dc, dcc)
	var ac_chance = rnd.randomi(agi)
	d = d + (d * ac_chance)
	if ac_chance < (agi / 2):
		d = d - t_ac
	if d <= t_dr or (d - t_dr <= 0):
		d = 0
	
	if d<= 0:
		d = 0
	print("atk value->",d)
	return d











