extends GameObject
class_name GamePlayer

var actor:GameActor

@onready var game_ui = %game_ui
@onready var debug_window = %debug_window

func _init():
	pass

func _ready():
	setup()
	bind_event()
	
func _process(_delta):
	pass

func setup():
	actor = GameActor.new()
	game_ui.player = self
	debug_window.player = self
	
func bind_event():
	pass

