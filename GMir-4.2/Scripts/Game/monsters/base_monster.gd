extends MonsterObject
class_name BaseMonster


func _init() -> void:
	properties = MonsterProperties.new() as MonsterProperties

func _ready():
	pass

func setup_stat():
	properties.level = 1
	properties.expv = 5
	properties.hp_max = 100
	properties.mp_max = 1
	properties.hp = properties.hp_max
	properties.mp = properties.mp_max
	properties.dc = 1
	properties.dcc = 2
	properties.atk_spd = 0.5
