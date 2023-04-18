extends Control
class_name Stats

export (int,0) var hp = 0
export (int,0) var hp_max = 0

export (int,0) var mp = 0
export (int,0) var mp_max = 0

export (int,0) var expr = 0
export (int,0) var expr_max = 0

export (int,1) var level = 1

export (String) var player_name = ""
export (String) var class_type = ""

export(Dictionary) var stats = {}

onready var m_player_name:Label = get_node('%player_name')
onready var m_player_class:Label = get_node('%class_type')
onready var m_level:Label = get_node('%lbl_level_value')

onready var m_hp:TweenProgress = get_node('%hp')
onready var m_mp:TweenProgress = get_node('%mp')
onready var m_exp:TweenProgress = get_node('%c_exp')

const FULL = 100

func update():
	m_player_name.text = player_name
	m_player_class.text = Globals.CLASS_NAME[class_type]

	var p_hp = GameUtils.get_percent(hp,hp_max)
	var p_mp = GameUtils.get_percent(mp,mp_max)
	var p_exp = GameUtils.get_percent(expr,expr_max)

	m_hp.t_max = hp_max
	m_hp.t_val = hp

	m_mp.t_max = mp_max
	m_mp.t_val = mp

	m_exp.t_max = expr_max
	m_exp.t_val = expr

