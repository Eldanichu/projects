extends Control

export(String) var player_name = "player_name" setget set_player_name
export(String) var class_type = "class_type" setget set_class_type
export(int) var gold = 0 setget set_gold
export(int) var level = 0 setget set_level

export(int) var hp = 0 setget set_hp
export(int) var hp_max = 0 setget set_hp_max
export(int) var mp = 0 setget set_mp
export(int) var mp_max = 0 setget set_mp_max
export(int) var iExp = 0 setget set_exp
export(int) var iExp_max = 0 setget set_exp_max


onready var lbl_player_name:Label = find_node('player_name')
onready var lbl_player_class:Label = find_node('class_type')
onready var lbl_gold:Label = find_node('gold')
onready var lbl_level:Label = find_node('lbl_level_value')
onready var hp_bar:TweenProgress = find_node('hp')
onready var mp_bar:TweenProgress = find_node('mp')
onready var exp_bar:TweenProgress = find_node('exp_bar')

signal hp_change(hp, damage)
signal mp_change(mp, used)
signal exp_change(present_exp, percent, exp_income)

func _ready() -> void:
  update_stats()

func _process(delta: float) -> void:
  update_stats()

func update_stats():
  lbl_player_name.text = player_name
  lbl_player_class.text = str(class_type)
  lbl_gold.text = str(gold)
  lbl_level.text = str(level)
  hp_bar.b_text = GameUtils.set_label_text( str(hp), str(hp_max), str(hp_bar.b_percent ) )
  mp_bar.b_text = GameUtils.set_label_text( str(mp), str(mp_max), str(mp_bar.b_percent) )
  exp_bar.b_text = GameUtils.set_label_text( str(iExp), str(iExp_max), str(exp_bar.b_percent) )

func set_class_type(new_val):
  class_type = new_val
  Store.player.class_type = class_type

func set_player_name(new_val):
  player_name = new_val
  Store.player.player_name = player_name

func set_gold(new_val):
  gold = new_val
  Store.player.gold = gold

func set_level(new_val):
  level = new_val
  Store.player.level = level

func set_hp(val):
  hp = val
  if val<0:
    hp = 0
  Store.player.hp = hp
  hp_bar.duration = 0.5
  hp_bar.b_percent = GameUtils.get_percent(hp,hp_max)
  emit_signal("hp_change",hp,val)

func set_mp(val):
  mp = val
  if val<0:
    mp = 0
  Store.player.mp = mp
  mp_bar.duration = 0.5
  mp_bar.b_percent = GameUtils.get_percent(mp,mp_max)
  emit_signal("mp_change",mp,val)

func set_exp(val):
  iExp = val
  var _pt = GameUtils.get_percent(iExp,iExp_max)
  if _pt >= 100:
    _pt = 100
  if val<0:
    iExp = 0
  Store.player.iExp = iExp
  exp_bar.duration = 0.5
  exp_bar.b_percent = _pt
  emit_signal("exp_change",iExp,exp_bar.b_percent,val)

func set_hp_max(val):
  if val<0:
    hp_max = 0
    return
  Store.player.hp_max = hp_max
  hp_max = val;

func set_mp_max(val):
  if val<0:
    mp_max= 0
    return
  Store.player.mp_max = mp_max
  mp_max = val;

func set_exp_max(val):
  if val<0:
    iExp_max = 0
    return
  Store.player.iExp_max = iExp_max
  iExp_max = val;



