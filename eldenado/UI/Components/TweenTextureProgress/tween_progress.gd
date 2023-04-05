extends MarginContainer
class_name TweenProgress

onready var pg:TextureProgress = $pg
onready var lbl_text:Label = get_node("%text")
onready var tween_pg:Tween = get_node("%tween_pg")

export(float) var v_val = 0 setget set_v_val
export(float) var v_max = 100 setget set_v_max

export(String) var t_val = "0" setget set_t_val
export(String) var t_max = "0" setget set_t_max

export(float,0,1) var duration = 0.5
export(Texture) var texture

var tween_is_start = false
var p_percent = 0

func _ready() -> void:
	setup()

func _process(delta: float) -> void:
	set_value_tween()

func setup():
	tween_pg.connect("tween_started",self,"_on_tween_pg_tween_started")
	tween_pg.connect("tween_completed",self,"_on_tween_pg_tween_completed")
	pg.texture_progress = texture
	set_value_tween();

func set_value_tween():
	lbl_text.text = "{0}/{1}".format([t_val,t_max])
	pg.max_value = v_max

	if tween_is_start:
		return
	tween_pg.interpolate_property(
		pg,"value",
		p_percent,v_val,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	p_percent = v_val
	tween_pg.start()

func set_v_val(v):
	v_val = v

func set_v_max(v):
	v_max = v

func set_t_val(v):
	t_val = v

func set_t_max(v):
	t_max = v

func _on_tween_pg_tween_completed(object: Object, key: NodePath) -> void:
	tween_is_start = false

func _on_tween_pg_tween_started(object: Object, key: NodePath) -> void:
	tween_is_start = true
