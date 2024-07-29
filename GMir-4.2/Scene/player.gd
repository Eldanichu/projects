extends PlayerObject
class_name PlayerNode

@onready var spawner:Spawner = $"../.."
@onready var _gui:GUI = spawner.gui

func _init():
	super(PlayerData.player_class)

func _ready():
	if not spawner is Spawner:
		printerr("player node exists in wrong place.")
		return
	setup()
	bind_ui_event()

func setup():
	spawner.player.target = self
	properties.hp = properties.hp_max
	properties.dc = 1
	properties.dcc = 5
	update_ui()

func update_ui():
	if not _gui:
		return
	_gui.pui(self)


func bind_ui_event():
	_gui.attack.pressed.connect(player_attack)

func player_attack():
	if not spawner.monster.has("target"):
		return
	BaseAttack.new(self).melee_attack(spawner.monster.target)

func set_lv_up():
	level_up()
	update_ui()









