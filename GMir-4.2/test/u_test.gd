extends Control

var rnd = RandomEx.get_instance()


@onready var lvl: Label = $lvl
@onready var vdc: Label = %vdc
@onready var vdc_2: Label = %vdc2

var ilvl:int = 1
func _ready():
	calc()
	pass

func _on_minus_button_up() -> void:
	ilvl = ilvl - 1
	lvl.text = str(ilvl)
	calc()

func _on_plus_button_up() -> void:
	ilvl = ilvl + 1
	lvl.text = str(ilvl)
	calc()

func calc():
	var dc = DCConst.new(ilvl)
	vdc_2.text = str(dc.value_max())
	vdc.text = str(dc.value())
