extends HBoxContainer

@export
var color:Color = Color.WHITE

@export
var stat_value:float = 0.0

@onready
var value:Label = %value


func _ready():
	set_value()

func _process(_delta):
	set_value()

func set_value():
	if stat_value == null:
		return
	value.text = str(stat_value)
