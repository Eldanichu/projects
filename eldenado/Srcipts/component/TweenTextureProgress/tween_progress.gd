extends MarginContainer
class_name TweenProgress

export(int) var b_percent = 0 setget set_b_percent
export(String) var b_text = 0 setget set_b_text
export(int,-64,64) var duration = 0.5
export(Texture) var texture

onready var pg:TextureProgress = $pg
onready var lbl_text:Label = $pg/text
onready var tween_pg:Tween = $tween_pg

var tween_is_start = false

func _ready() -> void:
  pg.max_value = 100
  pg.texture_progress = texture

func set_b_percent(new_percent):
  if b_percent <= 0:
    b_percent = 0
  tween_pg.interpolate_property(
    pg,"value",
    b_percent,new_percent,
    duration,
    Tween.TRANS_SINE,
    Tween.EASE_IN
  )
  b_percent = new_percent
  if !tween_is_start:
    tween_pg.start()
  yield(tween_pg,"tween_started")
  tween_is_start = true
  yield(tween_pg,"tween_completed")
  tween_is_start = false

func set_b_text(new_text):
  lbl_text.text = new_text
  pass

# unused
func get_delay() -> float:
  var _delay = 0
  if b_percent == 100:
    _delay = duration + 0.5
  return _delay
