extends HBoxContainer

const icon_no_image = preload("res://Assets/Icons/no-image.tres")

@export
var icon:AtlasTexture

@export
var color:Color = Color.WHITE

@export
var stat_value:float = 0.0

@onready
var img:TextureRect = %img

@onready
var value:Label = %value


func _ready():
	img.texture = icon
	set_value()
	update_icon()

func _process(_delta):
	set_value()
	update_icon()

func update_icon():
	if icon == null:
		img.texture = icon_no_image
		return
	img.texture = icon
	img.modulate = color

func set_value():
	if stat_value == null:
		return
	value.text = str(stat_value)
