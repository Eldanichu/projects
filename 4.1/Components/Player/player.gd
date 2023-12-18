extends GameObject
class_name GamePlayer

var player:ActorPlayer

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
	player = ActorPlayer.new()
	player.set_class(TaoClass.new(player))
	game_ui.player_scene = self
	debug_window.player_scene = self
	
func bind_event():
	pass

