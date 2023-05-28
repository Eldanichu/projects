extends TextureButton
class_name Item

onready var _size := $"%size"
onready var lbl_test := $test
onready var _cd := $"%cd"

enum ITEM_STATE {
	MOVING,
	IN_SLOT,
	COOLDOWN,
	USEABLE
}

var item:ItemObject setget set_item
var skill:SkillObject setget set_skill
var timer:ATimer

var _state:int = ITEM_STATE.IN_SLOT
var _cd_value:float = 0
var tween:Tween = Tween.new()
var mouse_in:bool = false

func _ready():
	add_child(tween)
	timer = ATimer.new(self)
	timer.connect("remains", self, "_on_item_cooldown")
	timer.connect("timeout", self, "_on_item_can_use")

func _process(delta):
	show_size()
	if item:
		show_item_icon()
	if skill:
		show_skill_icon()
	usibility()

func _input(event):
	if !mouse_in:
		return
	if InputUtil.mouse_click(event,1):
		button_mask = BUTTON_MASK_LEFT
	if InputUtil.mouse_click(event,2):
		button_mask = BUTTON_MASK_RIGHT

func set_item(item_object:ItemObject):
	item = item_object
	item.useable = true

func set_skill(skill_object:SkillObject):
	skill = skill_object
	
func valid_item():
	return is_instance_valid(item)

func show_skill_icon():
	if !skill || !skill.icon:
		set_normal_texture(null)
		return
	var icon = skill.icon
	var texture = ResUtil.get_res_image(skill.item_type, icon)
	set_normal_texture(texture)
	if tween.is_active():
		return
	_cd.value = get_cd_value()

func show_item_icon():
	if !item || !item.icon || !item.exist():
		set_normal_texture(null)
		return
	var icon = item.icon
	var texture = ResUtil.get_res_image(item.item_type, icon)
	set_normal_texture(texture)
	
	if tween.is_active():
		return
	_cd.value = get_cd_value()

func show_size():
	if !item || !item.exist():
		_size.visible = false
		return
	if item.size > 0:
		_size.text = str(item.size)
		_size.visible = true
	else:
		_size.visible = false

func usibility():
	if !item || !item.exist() || !skill || !skill.exist():
		lbl_test.text = "E"
		
		_cd.mouse_filter = MOUSE_FILTER_PASS
		mouse_filter = MOUSE_FILTER_PASS
		return
	if item.useable || skill.useable:
		lbl_test.text = "T"
		
		_cd.mouse_filter = MOUSE_FILTER_PASS
	else:
		lbl_test.text = "F"
		
		_cd.mouse_filter = MOUSE_FILTER_STOP

func get_cd_value():
	var _cd
	if item && "cd" in item:
		_cd = item.cd
	elif skill && "cd" in skill:
		_cd = skill.cd
	var p = GameUtils.get_percent(_cd_value, _cd)
	return p

func _to_value(value):
	tween.interpolate_property(
		_cd,
		"value",
		_cd.value,
		max(0,value),
		0.1,
		Tween.TRANS_CUBIC,Tween.EASE_IN_OUT
	)
	tween.start()

func _on_item_pick():
	_state = ITEM_STATE.MOVING
	var main = GameUtils.get_root_node(self,"main")
	var mi:MouseItem = main.get_node("mouse_item")
	if !item || !item.exist():
		if mi.exist():
			var _new_item:ItemObject = ItemObject.new()
			_new_item.set_object(mi.get_object())
			set_item(_new_item)
			Event.emit_signal("put_item",_new_item)
			mi.remove()
		return
	if !item.pickable:
		return
	if item.exist() && mi.exist():
		# save slot item as temp
		var temp:ItemObject = ItemObject.new()
		temp.set_object(item.to_object())
		# remove slot item
		item.remove()
		# set mouse item to slot
		var _mouse_item := ItemObject.new()
		_mouse_item.set_object(mi.get_object())
		set_item(_mouse_item)
		Event.emit_signal("put_item",_mouse_item)
		mi.remove()
		# add temp item to mouse
		mi.set_item(temp)
		return
	if item.exist():
		var _new_item:ItemObject = ItemObject.new()
		_new_item.set_object(item.to_object())
		mi.set_item(_new_item)
		Event.emit_signal("pick_item", _new_item)
		item.remove()

func _on_item_use():
	if !item || !item.exist() || !item.useable:
		return
	item.use()
	if item.size <= 0:
		item.remove()
	item.useable = false
	_state = ITEM_STATE.COOLDOWN
	timer.Interval = item.cd
	timer.start_timer()

func use_skill():
	if !skill || !skill.exist() || !skill.useable:
		return
	Event.emit_signal("player_attack", skill.skill_inst)
	skill.useable = false
	_state = ITEM_STATE.COOLDOWN
	timer.Interval = skill.cd
	timer.start_timer()

func _on_item_can_use():
	if item && item.exist():
		item.useable = true
	if skill && skill.exist():
		skill.useable = true
	_state = ITEM_STATE.USEABLE
	_cd_value = 0
	timer.stop()

func _on_item_cooldown(delta):
	_cd_value = delta

func _on_item_button_up():
	if button_mask == BUTTON_MASK_LEFT:
		_on_item_pick()
	if button_mask == BUTTON_MASK_RIGHT:
		_on_item_use()

func _on_item_mouse_entered():
	mouse_in = true

func _on_item_mouse_exited():
	mouse_in = false
