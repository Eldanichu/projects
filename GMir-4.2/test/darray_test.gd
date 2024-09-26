extends Control

@onready var lines: BoxContainer = %lines

var unode:UNode = UNode.new(self)
var da:DArray = DArray.new()
var arow = preload("res://test/arow.tscn")

func _on_add_row_button_up() -> void:
	var row:ARow = arow.instantiate() as ARow
	unode.p(lines)
	var n:ARow = unode.add_node("arow",row)
	n.on_click.connect(_on_delete_row)
	n.on_input.connect(_on_row_input)


func _on_delete_row(this):
	print(this.name)
	unode.p(lines)
	unode.remove_node(this.name)
	#da.remove_index(idx)
	print(da._dict)


func _on_row_input(idx,input_str):
	da.set_v_at(idx,input_str)
	print(da._dict)
