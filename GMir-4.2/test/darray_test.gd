extends Control

@onready var lines: BoxContainer = %lines

var unode:UNode = UNode.new(self)
var da:DArray = DArray.new()


func _on_add_row_button_up() -> void:
	var row = load("res://Test/line_row.tscn").instantiate()
	unode.p(lines)
	var n = unode.add_node("arow",row)
	n.on_click.connect(_on_delete_row)
	n.on_input.connect(_on_row_input)
	da.push({"dc":randf()},"n_"+n.name)

func _on_delete_row(this):
	print(this.name)
	unode.p(lines)
	unode.remove_node(this.name)
	da.remove_key("n_"+this.name)


func _on_row_input(this,input_str):
	da.set_v_key("n_"+this.name,input_str)
	print(da._dict)
