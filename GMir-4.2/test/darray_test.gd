extends Control

@onready var lines: BoxContainer = %lines

var unode:UNode = UNode.new(self)
var da:DArray = DArray.new()


func _ready() -> void:

	pass

func _on_add_row_button_up() -> void:
	var row = ResourceLoader.load("res://test/line_row.tscn").instantiate() as LineRow
	unode.p(lines)
	var n:LineRow = unode.add_node("",row) 
	n.on_click.connect(_on_delete_row)
	n.on_input.connect(_on_row_input)
	print(unode.get_nodes(lines))

func _on_delete_row(this):
	print(this.name)
	unode.p(lines)
	unode.remove_node(this.name)

func _on_row_input(this, input_str):
	#da.set_v_key(this.name,input_str)
	pass
