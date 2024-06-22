extends MonsterObject
class_name BaseMonster

func _init():
	properties = BaseProperties.new()
	pass

func setup_stat():
	properties.hp = properties.hp_max
	properties.mp = properties.mp_max

func calculate() -> void:
	properties.level = 1
	properties.expv = 300
	properties.hp_max = 100
	properties.mp_max = 0
