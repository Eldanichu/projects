extends BaseMonster
class_name MonNode

@onready var spawner:Spawner = $"../.."
@onready var _gui:GUI = spawner.gui

var _target:GameObject

func _init():
	super()

func _ready():
	setup()

func setup():
	setup_stat()
	update_ui()
	if spawner.player.has("target"):
		set_target(spawner.player.target)

func set_target(target:GameObject):
	_target = target as GameObject
	set_attck(_target, properties.atk_spd)
	attack_method(melee_attack)

func melee_attack(tick:int):
	BaseAttack.new(self).melee_attack(_target)

func update_ui():
	if not _gui:
		return
	_gui.mui(self)

	
	











