extends Control

export(int) var hp = 0 setget set_hp
export(int) var hp_max = 0 setget set_hp_max
export(int) var mp = 0 setget set_mp
export(int) var mp_max = 0 setget set_mp_max
export(int) var iExp = 0 setget set_exp
export(int) var iExp_max = 0 setget set_exp_max


onready var hp_bar:TweenProgress = $v_box_container/hp
onready var mp_bar:TweenProgress = $v_box_container/mp
onready var exp_bar:TweenProgress = $v_box_container/exp_bar

signal hp_change(hp, damage)
signal mp_change(mp, used)
signal exp_change(present_exp, percent, exp_income)

func _process(delta: float) -> void:
  update_stats()

func update_stats():
  hp_bar.b_text = GameUtils.set_label_text( str(hp), str(hp_max), str(hp_bar.b_percent ) )
  mp_bar.b_text = GameUtils.set_label_text( str(mp), str(mp_max), str(mp_bar.b_percent) )
  exp_bar.b_text = GameUtils.set_label_text( str(iExp), str(iExp_max), str(exp_bar.b_percent) )


func set_hp(val):
  hp = val
  if val<0:
    hp = 0
  hp_bar.duration = 0.5
  hp_bar.b_percent = GameUtils.get_percent(hp,hp_max)
  emit_signal("hp_change",hp,val)

func set_mp(val):
  mp = val
  if val<0:
    mp = 0
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
  exp_bar.duration = 0.5
  exp_bar.b_percent = _pt
  emit_signal("exp_change",iExp,exp_bar.b_percent,val)

func set_hp_max(val):
  if val<0:
    hp_max = 0
    return
  hp_max = val;

func set_mp_max(val):
  if val<0:
    mp_max= 0
    return
  mp_max = val;

func set_exp_max(val):
  if val<0:
    iExp_max = 0
    return
  iExp_max = val;



