extends Control
class_name GUI

@onready var ui_property = $ui_property
@onready var bar = $Bar
@onready var h_slider = $h_slider
@onready var interval = %interval
@onready var timer_scale = %timer_scale

@onready var page_stat = %page_stat

var timer:TimerEx = TimerEx.new(self)
var is_tick = false

var u_props:Dictionary = {}
func _ready():
	cache_prop_ui_nodes()
	ui_property.val = 0
	h_slider.value_changed.connect(_on_slider_value_changed)
	timer.interval = interval.text
	timer.on_tick.connect(_on_timer_tick)
	timer.on_timeout.connect(_on_timer_timeout)

func cache_prop_ui_nodes():
	var lines = page_stat.get_children()
	for col in lines:
		u_props[col.name] = col

func update_prop_ui(player:PlayerNode):
	var props = player.properties.prop
	for key in props:
		if not key in u_props:
			continue
		u_props[key].label = G.DIC_CHAR_PROP[key]["key"]
		u_props[key].val = str(props[key])

func _on_slider_value_changed(delta):
	bar.v_min = delta

func _on_timer_tick(delta):
	#print(delta)
	if is_tick:
		ui_property.val = 1 + int(ui_property.val)
		return
	ui_property.val = delta

func _on_timer_timeout():
	print("to")

func _on_button_button_up():
	timer.interval = interval.text
	timer.start()

func _on_set_scale_button_up():
	timer.set_time_scale(float(timer_scale.text))

func _on_is_tick_timer_toggled(toggled_on):
	is_tick = toggled_on
	timer.tick = is_tick

