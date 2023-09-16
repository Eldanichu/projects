extends HBoxContainer

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

func _process(delta):
	set_value()
	if icon == null:
		img.texture = load("res://Assets/Icons/no-image.tres")
		return
	img.texture = icon
	img.modulate = color

func set_value():
	if stat_value == null:
		return
	value.text = str(stat_value)
