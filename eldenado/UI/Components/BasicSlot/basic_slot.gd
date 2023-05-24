extends Control
class_name BasicSlot, "res://Assets/ui/panel/00670.PNG"

signal use_skill(item)
signal pick(item)
signal use_item(item)

enum SLOT_TYPE {
	SKILL = 0,
	EQUIP = 1,
	SKILL_ITEM = 2
}

enum SLOT_ACTION {
	USE = 1,
	MOVE = 2
}

export(SLOT_TYPE) var slot_type = 0
export(float) var interval = 0.0

const SKILL_PATH = [2]

const PATH_TYPE = {
	1:"Items",
	0:"Skill/icon"
}

const EVENT:Dictionary = {
	"USE_SKILL":"use_skill",
	"USE_ITEM":"use_item",
}

onready var slot_label = $"%label"
onready var slot_img = $"%img"
onready var progress := $"%progress"

var t := Tween.new()
var timer:ATimer = ATimer.new(self)
var _timeleft = 0

var _is_mouse_in = false
var can_click = false
var slot_key:String = "" setget set_slot_key

var item:Dictionary = {
	"id":"",
	"type":"",
	"appr":"",
} setget set_item

func _ready() -> void:
	add_child(t)
	setup()

func _input(event) -> void:
	if !can_click || !has_item():
		return
	global_mouse_event(event)
	self_click_event(event)

func self_click_event(event):
	if !_is_mouse_in || !can_use():
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
	for b in bindings:
		var item = bindings[b]
		if  b != "sep" && "default" in item && item["default"] == 1:
			if (
				slot_type == SLOT_TYPE.SKILL && \
				(InputUtil.mouse_click(event, item.key_code) && slot_key == item.key) && \
				can_use()
			):
				emit_event(EVENT.USE_SKILL)

func emit_event(ev_name):
		_on_press()
		emit_signal(ev_name, item)

func _process(delta):
	if interval == 0:
		timer.stop()
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
	_timeleft = time_left
	progress.value = GameUtils.get_percent(_timeleft, interval)

func _on_timeout():
	timer.stop()

func setup():
	timer.Interval = interval
	progress.max_value = 100
	progress.value = GameUtils.get_percent(_timeleft, interval)

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
	var res
	var path
	if item.type in PATH_TYPE :
		path = PATH_TYPE[item.type]
	if SKILL_PATH.has(item.type):
		path = PATH_TYPE[0]
	res = ResourceLoader.load("res://Assets/{0}/{1}.png".format([path,item.appr]))
	slot_img.texture = res

func set_slot_key(n):
	slot_key = str(n)
	update()

func set_item(_item:Dictionary):
	var required_props:Array = ["id", "appr", "type"]
	item.merge(_item, true)
	if ObjectUtil.has_value(item,"cd"):
		interval = item["cd"]
		timer.Interval = interval

	for o in _item:
		if !ObjectUtil.has_value(_item, o) && required_props.has(o):
			print(
				"[basic_slot.tscn]->[****Error****]:" + \
					"Slot required property: [{0}] is empty".format([o])
			)
	animate_disabled()
	update_img()

func animate_disabled():
	if ObjectUtil.has_value(item,"disabled"):
		if item["disabled"]:
			_timeleft = timer.Interval
			progress.value = GameUtils.get_percent(_timeleft, interval)
		else:
			t.stop_all()
			t.interpolate_property(
				progress,"value",progress.value,0,0.1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
			)
			t.start()

func has_item():
	return !StringUtil.isEmptyOrNull(item.id)

func can_use():
	return "disabled" in item && !item.disabled

func _on_mouse_in_slot(in_out) -> void:
	_is_mouse_in = in_out

