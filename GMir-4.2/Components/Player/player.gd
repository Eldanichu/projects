extends GameObject
class_name GamePlayer

var player:ActorPlayer

@onready var game_ui := %game_ui
@onready var debug_window := %debug_window

var attack_timer:TimerEx = TimerEx.new(self)

func _init():
	pass

func _ready():
	setup()
	
func _process(_delta):
	pass

func setup():
	create()
	bind_event()
	update_ui()

func create():
	player = ActorPlayer.new()
	player.set_class(TaoClass.new(player))

func update_ui():
	game_ui.player = player
	game_ui.initialize(self)
	debug_window.player = player

func bind_event():
	attack_timer.on_timeout.connect(_on_player_attack)
	
func start_battle():
	attack_timer.interval = player.stats.ATKSPD / 1000.0
	attack_timer.tick = false
	attack_timer.start()

func stop():
	attack_timer.reset()
	attack_timer.clear()

func _on_player_attack():
	attack_timer.start()
	player.on_attack.emit()

