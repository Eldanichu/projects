extends BaseMonster
class_name MonNode

@onready var spawner:Spawner = $"../.."
@onready var _gui:GUI = spawner.gui

func _init():
	super()

func _ready():
	setup()
	bind_ui_event()

func setup():
	calculate()
	setup_stat()
	update_ui()

func update_ui():
	if not _gui:
		return
	_gui.mui(self)


func bind_ui_event():
	pass










