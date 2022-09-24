extends Control
class_name Stats

onready var m_player_name:Label = get_node('%player_name')
onready var m_player_class:Label = get_node('%class_type')
onready var m_gold:Label = get_node('%gold')
onready var m_level:Label = get_node('%lbl_level_value')

onready var m_hp:TweenProgress = get_node('%hp')
onready var m_mp:TweenProgress = get_node('%mp')
onready var m_exp:TweenProgress = get_node('%c_exp')

export (int) var Hp = 0
export (int) var MaxHp = 0

export (int) var Mp = 0
export (int) var MaxMp = 0

export (int) var Exp = 0
export (int) var MaxExp = 0

export (int,1) var Level = 1 setget set_level

export (String) var Gold = "0"

export (String) var PlayerName = "Player0"
export (String) var PlayerClass = "战士"


func _ready() -> void:
  setup()

func _process(delta: float) -> void:
  setup()

func setup() -> void:
  get_stats()


func get_stats():
  m_player_name.text = PlayerName
  m_player_class.text = PlayerClass
  m_gold.text = Gold

  var p_hp = GameUtils.get_percent(Hp,MaxHp)
  var p_mp = GameUtils.get_percent(Mp,MaxMp)
  var p_exp = GameUtils.get_percent(Exp,MaxExp)
  m_hp.set_v_max(100)
  m_hp.set_v_val(p_hp)

  m_mp.set_v_max(100)
  m_mp.set_v_val(p_mp)

  m_exp.set_v_max(100)
  m_exp.set_v_val(p_exp)

  m_hp.set_t_max(MaxHp)
  m_hp.set_t_val(Hp)

  m_mp.set_t_max(MaxMp)
  m_mp.set_t_val(Mp)

  m_exp.set_t_max(MaxExp)
  m_exp.set_t_val(Exp)


func set_level(v) -> void:
  Level = v
