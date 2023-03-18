extends Node2D

onready var stat := $gmae_ui/control/v_box_container/top_container/stats

var player:Player
var _player_info

func _ready() -> void:
	pass

func _process(delta):
	stat.update()

func setup(player_info:Dictionary):
	print('created game', player_info)
	_player_info = player_info
	create_player()
	
func create_player():
	player = Player.new()
	add_child(player)
	player.connect("update_stats",self,"update_panel",[player])
	player.setup(_player_info)

func update_panel(stats:Array,player:Player):
	yield(self,"ready")
	var _class = Globals.CLASS_NAME[player.class_type]
	stat.PlayerClass = _class
	stat.PlayerName = player.player_name
	stat.Hp = stats[0]
	stat.MaxHp = stats[1]
	stat.Mp = stats[2]
	stat.MaxMp = stats[3]
	stat.Exp = stats[4]
	stat.MaxExp = stats[5]
	stat.Level = stats[6]
