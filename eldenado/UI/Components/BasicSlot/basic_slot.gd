extends Control
class_name BasicSlot, "res://Assets/ui/panel/00670.PNG"

signal use_skill(item)
signal pick(item)
signal use_item(item)

enum SLOT_TYPE {
	SKILL = 0,
	EQUIP = 1
}

enum SLOT_ACTION {
	USE = 1,
	MOVE = 2
}

const PATH_TYPE = {
	1:"Items",
	0:"Skill/icon"
}

const EVENT:Dictionary = {
	"USE_SKILL":"use_skill",
	"USE_ITEM":"use_item",
}

export(SLOT_TYPE) var slot_type = 0
export(float) var interval = 1

onready var slot_label = $"%label"
onready var slot_img = $"%img"
onready var progress := $"%progress"

var timer:ATimer = ATimer.new(self)

var _is_mouse_in = false
var can_click = false
var slot_key:String = "" setget set_slot_key

var item:Dictionary = {
	"id":"",
	"type":"",
	"appr":"",
} setget set_item

func _ready() -> void:
	setup()

func _input(event) -> void:
	if !can_click || !has_item():
		return
	global_mouse_event(event)
	self_click_event(event)

func self_click_event(event):
	if !_is_mouse_in:
		return
	if InputUtil.mouse_click(event, 1):
		if slot_type == SLOT_TYPE.SKILL:
			emit_event(EVENT.USE_SKILL)
		elif slot_type == SLOT_TYPE.EQUIP:
			emit_signal("pick", item)
	if InputUtil.mouse_dbClick(event, 1):
		if slot_type == SLOT_TYPE.EQUIP:
			emit_event(EVENT.USE_ITEM)
			print("use item")

func global_mouse_event(event):
	var settings = Store.settings
	var bindings = settings.key_bindings
	var attack = bindings["Attack"]
	var skill = bindings["Skill"]
	if (
		slot_type == SLOT_TYPE.SKILL && \
		(
			InputUtil.mouse_click(event, attack.key_code) && slot_key == attack.key || \
	 		InputUtil.mouse_click(event, skill.key_code) && slot_key == skill.key
		)
	):
		emit_event(EVENT.USE_SKILL)

func emit_event(ev_name):
		_on_press()
		emit_signal(ev_name, item)

func _process(delta):
	if interval == 0:
		interval = -1
	if progress.value <= 0:
		progress.mouse_filter = MOUSE_FILTER_PASS
		can_click = true
	if progress.value > 0:
		progress.mouse_filter = MOUSE_FILTER_STOP
		can_click = false

func _on_press():
	if timer.is_stopped():
		timer.start_timer()

func _on_timing(time_left):
	progress.value = GameUtils.get_percent(time_left, interval)

func _on_timeout():
	timer.stop()

func setup():
	timer.Interval = interval
	progress.max_value = 100
	progress.value = 0

	update_label()
	bind_events()

func bind_events():
	progress.connect("mouse_entered",self,"_on_mouse_in_slot",[true])
	progress.connect("mouse_exited",self,"_on_mouse_in_slot",[false])
	timer.connect("remains",self,"_on_timing")
	timer.connect("timeout",self,"_on_timeout")

func update_label():
	var color = Color.white
	color.a = 0.6
	if slot_type == SLOT_TYPE.SKILL:
		slot_label.set("align", HALIGN_RIGHT)
		slot_label.set("valign", VALIGN_BOTTOM)
		slot_label.visible = true
	else:
		slot_label.set("align", HALIGN_CENTER)
		slot_label.set("valign", VALIGN_CENTER)
		slot_label.visible = false
	slot_label.set("custom_colors/font_color", color)

func update():
	if !is_inside_tree():
		return
	slot_label.text = str(slot_key)

func update_img():
	if !is_inside_tree():
		return
	var res = ResourceLoader.load("res://Assets/{0}/{1}.png".format([PATH_TYPE[item.type],item.appr]))
	slot_img.texture = res
	pass

func set_slot_key(n):
	slot_key = str(n)
	update()

func set_item(_item:Dictionary):
	if _has_value(_item, "id"):
		item.id = _item.id
	if _has_value(_item, "appr"):
		item.appr = _item.appr
	if _has_value(_item, "type"):
		item.type = _item.type
	update_img()

func _has_value(obj,key):
	return key in obj && obj[key] != null

func has_item():
	return !StringUtil.isEmptyOrNull(item.id)

func _on_mouse_in_slot(in_out) -> void:
	print(in_out)
	_is_mouse_in = in_out

