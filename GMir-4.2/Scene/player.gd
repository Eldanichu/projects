extends PlayerObject
class_name PlayerNode

@onready var spawner:Spawner = $"../.."
@onready var _gui:GUI = spawner.gui
var rnd = RandomEx.get_instance()

func _init():
	super(BaseJob.JOB.Wizard)

func _ready():
	setup()
	bind_ui_event()

func setup():
	#var prop_set_config = {
		#"times":0,
		#"interval":0.3,
		#"type":"0",
		#"action":"+"
	#}
	#prop_set_tick("hp", 2, properties.hp_max, prop_set_config, update_ui)
	#prop_set_tick("mp", 2, properties.mp_max, prop_set_config, update_ui)
	properties.dc = 1
	properties.dcc = 5
	#var vt:ValueTick = ValueTick.new(self)
	#vt.set_tick_type(vt.TICK_TYPE.NUMBER)
	#vt.set_tick_action(vt.TICK_ACTION.PLUS)
	#vt.set_max_value(properties.hp_max)
	#vt.TKey = "hp"
	#vt.TValue = 2
	#vt.update_func = update_ui
	#vt.start()


	update_ui()

func update_ui():
	if not _gui:
		return
	_gui.pui(self)


func bind_ui_event():
	spawner.player.attack = player_attack

func player_attack():
	BaseAttack.new(self).melee_attack(spawner.monster.target)
	set_lv_up()
	

func set_lv_up():
	level_up()
	update_ui()









