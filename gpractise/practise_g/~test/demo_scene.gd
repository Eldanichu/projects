extends Control
class_name DemoScene

@onready var grid: GridContainer = %grid
var rnd := RandomEx.get_instance()

func _ready() -> void:
	var lbl:Label
	for i in range(0,10):
		lbl = Label.new()
		lbl.text = str("lb_text_{0}".format([i]))
		lbl.add_to_group("lb_texts")
		grid.add_child(lbl)
	var g = get_tree().get_nodes_in_group("lb_texts")

	var grid_i = 0
	var columns = grid.columns
	for n in g:
		var row = grid_i / columns
		var col = grid_i % columns
		n.text = "g_{0}_{1}".format([row,col])
		grid_i = grid_i + 1
	var max_col = min(grid_i, columns);
	var max_row = ceil(grid_i / columns);
	print("max ->"+"({0},{1})".format([max_col,max_row]) )
