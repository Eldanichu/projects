extends MonsterObject
class_name BaseMonster

@onready var attack_tick:TimerTick = TimerTick.new(self)

func _init():
	properties = MonsterProperties.new() as MonsterProperties
	pass

func _ready():
	
	pass

func attack_method(method:Callable):
	attack_tick.tick_method(method)

func set_attck(target:GameObject, interval:float):
	attack_tick.set_interval(interval)
	attack_tick.start()
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

