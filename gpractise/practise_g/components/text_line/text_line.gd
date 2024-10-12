extends Control
class_name CustomLabel

enum LABEL_ALIGN {
	LEFT = 1,
	RIGHT = 2,
	CENTER = 4
}

enum  LABEL_POSITION {
	TOP,
	CENTER,
	BOTTOM
}

@onready var ubox: BoxContainer = $"."
@onready var ulabel: Label = %ulabel
@onready var uvalue: Label = %uvalue
@onready var label_margin: MarginContainer = %label_margin

@export_category("Settings")
@export 
var vertical_label:bool = false:
	set(v):
		if ubox:
			vertical_label = v
			ubox.vertical = vertical_label
			_label_position_update()
@export 
var label_align:LABEL_ALIGN = LABEL_ALIGN.LEFT:
	set(v):
		if label_margin:
			label_align = v
			_label_align_update()
@export 
var label_position:LABEL_POSITION = LABEL_POSITION.CENTER:
	set(v):
		label_position = v
		if ubox:
			_label_position_update()

@export_category("Defaults")
@export
var label:String = "lbl":
	set(v):
		label = v
		_set_t(ulabel,label)
@export
var value = "val":
	set(v):
		value = v
		_set_t(uvalue,value)


func _ready() -> void:
	print("[text_line] ready")
	setup()
	_label_align_update()
func setup():
	_set_t(ulabel,label)
	_set_t(uvalue,value)

func _label_align_update():
	label_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	match(label_align):
		LABEL_ALIGN.LEFT:
			label_margin.size_flags_horizontal = Control.SIZE_FILL
			ulabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		LABEL_ALIGN.RIGHT:
			ulabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		LABEL_ALIGN.CENTER:
			ulabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

func _label_position_update():
	if ubox.vertical:
		ulabel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	else:
		ulabel.size_flags_vertical = Control.SIZE_FILL
	match(label_position):
		LABEL_POSITION.TOP:
			ulabel.size_flags_vertical = HORIZONTAL_ALIGNMENT_LEFT
		LABEL_POSITION.BOTTOM:
			ulabel.size_flags_vertical = HORIZONTAL_ALIGNMENT_RIGHT
		LABEL_POSITION.CENTER:
			ulabel.size_flags_vertical = HORIZONTAL_ALIGNMENT_CENTER

func _set_t(node:Node, s):
	if not node:
		return
	node.call_deferred("set_text",str(s))
