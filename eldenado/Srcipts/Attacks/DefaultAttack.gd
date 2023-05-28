extends Resource
class_name DefaultAttack

const instance_props:Array = [
	"id",
	"icon",
	"cd",
	"cast",
	"target",
]

var id = "default_attack"
var icon:String = "00000"
var cd:float = 0.6
var cast
var target

func _init() -> void:
	pass

func get_power() -> Array:
	var stats:Dictionary = cast.stats
	var ap = AttackPower.new(stats.dc, stats.dc_max)
	ap.CRIT_ATK_RATE = stats.crit_chance
	ap.CRIT_ATK_DMG_INC = stats.crit_strength
	var power = ap.calc()

	return [power,ap.is_crit_damage()]

func start() -> Array:
	var value = get_power()
	target.give_damage(value[0], Globals.DAMAGE_TYPE.ATTACK)

	return value

func get_log(power, critcle):
	var text:BattleLogText = BattleLogText.new()
	var c:Color = Color.greenyellow
	if critcle:
		c = Color.lightcoral
	var damage_text:BattleLogText = BattleLogText.new().color(c).set_text(power)
	text.text = "你对{0}造成{1}点伤害".format([
		target.mon_stat.name,
		damage_text.to_string()
	])
	return text

func to_object() -> Dictionary:
	var _props:Dictionary = {}
	for key in instance_props:
		_props[key] = self[key]
	return _props
