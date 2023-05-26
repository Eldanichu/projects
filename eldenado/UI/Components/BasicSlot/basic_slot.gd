extends Control
class_name BasicSlot, "res://Assets/ui/panel/00670.PNG"

signal use_skill(item)
signal pick(item)
signal use_item(item)

const SLOT_TYPE = Globals.SLOT_TYPE
const ITEM_SOURCE = Globals.ITEM_SOURCE
const EVENT:Dictionary = {
	"USE_SKILL":"use_skill",
	"USE_ITEM":"use_item",
}

export(ITEM_SOURCE) var slot_source = ITEM_SOURCE.UNKNOWN
export(SLOT_TYPE) var slot_type:int = SLOT_TYPE.EMPTY
export(float) var interval:float = 0.1

onready var slot_label = $"%label"
onready var slot_item_size = $"%size"
onready var slot_img = $"%img"
onready var progress := $"%progress"

var t := Tween.new()
var timer:ATimer = ATimer.new(self)
var _timeleft = 0

var _is_mouse_in = false
var can_click = false

var item:SlotObject = SlotObject.new()

func _ready() -> void:
	setup()

func _process(delta):
	update_label()
	update_slot_item_size_label()

	if progress.value <= 0:
		progress.mouse_filter = MOUSE_FILTER_PASS
		can_click = true

	if progress.value > 0:
		progress.mouse_filter = MOUSE_FILTER_STOP
		can_click = false

func _input(event) -> void:
	if !can_click:
		return
	_on_global_mouse_click(event)
	_on_slot_click(event)

func setup():
	add_child(t)
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

func set_item(_item:Dictionary):
	item.assign(_item)
	print("[basic slot](set_item: item)->",item.to_object())
	if item["cd"] > 0:
		interval = item["cd"]
		timer.Interval = interval

	if item.is_empty():
		return
	slot_type = item.type
	slot_source = item.from
	if !is_inside_tree():
		return
	update_img()
	animate_disabled()

func clear():
	item = SlotObject.new()
	if !is_inside_tree():
		return
	animate_disabled()
	update_img()

func update_label():
	var color = Color.white
	color.a = 0.6
	if [SLOT_TYPE.SKILL, SLOT_TYPE.EMPTY].has(slot_type) :
		slot_label.set("align", HALIGN_RIGHT)
		slot_label.set("valign", VALIGN_BOTTOM)
		slot_label.visible = true
	else:
		slot_label.set("align", HALIGN_CENTER)
		slot_label.set("valign", VALIGN_CENTER)
		slot_label.visible = false
	slot_label.set("custom_colors/font_color", color)
	slot_label.text = str(item.key)

func update_slot_item_size_label():
	if [SLOT_TYPE.USEABLE_ITEM].has(slot_type) && item.size:
		slot_item_size.visible = true
		var _size = int(item["size"])
		if _size >= 100:
			slot_item_size.text = "99+"
		else:
			slot_item_size.text = str(item["size"])
	else:
		slot_item_size.visible = false
		slot_item_size.text = ""

func update_img():
	var res = ResUtil.get_res_image(item.type,item.icon)
	slot_img.texture = res

func animate_disabled():
	t.stop_all()
	if !item.can_use():
		_timeleft = timer.Interval
		progress.value = GameUtils.get_percent(_timeleft, interval)
	else:
		t.interpolate_property(
			progress,"value",progress.value,0,0.1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
		)
		t.start()

"""
Events
"""
func _on_mouse_in_slot(in_out) -> void:
	_is_mouse_in = in_out

func _on_press():
	if timer.is_stopped():
		timer.start_timer()

func _on_timing(time_left):
	_timeleft = time_left
	progress.value = GameUtils.get_percent(_timeleft, interval)

func _on_timeout():
	timer.stop()

func _on_slot_click(event):
	if !_is_mouse_in:
		return
	if InputUtil.mouse_click(event, 1):
		if [SLOT_TYPE.SKILL].has(slot_type):
			emit_event(EVENT.USE_SKILL)
		elif [SLOT_TYPE.EQUIP, SLOT_TYPE.SKILL_ITEM, SLOT_TYPE.EMPTY, SLOT_TYPE.USEABLE_ITEM].has(slot_type):
			emit_signal("pick", item)
	if InputUtil.mouse_dbClick(event, 1):
		if [SLOT_TYPE.EQUIP, SLOT_TYPE.USEABLE_ITEM].has(slot_type):
			emit_event(EVENT.USE_ITEM)
			print("[basic slot ]-> use item event")

func _on_global_mouse_click(event):
	var settings = Store.settings
	var bindings = settings.key_bindings
	for b in bindings:
		if b == "sep":
			continue
		var binding_item = bindings[b]
		if  (
			("default" in binding_item) && \
			(binding_item["default"] == 1)
		):
			if (
				slot_type == SLOT_TYPE.SKILL && \
				(InputUtil.mouse_click(event, binding_item.key_code) && item.key == binding_item.key) &&\
				item.can_use() && !item.is_empty()
			):
				emit_event(EVENT.USE_SKILL)

func emit_event(ev_name):
		_on_press()
		emit_signal(ev_name, item)
