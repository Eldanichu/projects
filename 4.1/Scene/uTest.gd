extends Control

@onready
var box = %box

func _ready():
	var funcs = get_method_list()
	var prefix = "_el_test_"
	for fn in funcs:
		var fn_name:String = fn.name
		if fn_name.begins_with(prefix):
			var callable = Callable(self,fn_name)
			var btn_name = fn_name.replace(prefix,"")
			_create_func_buttons(btn_name,callable)
	pass


func _process(delta):
	pass

func _create_func_buttons(btn_name:String, fn_name:Callable):
	var button := Button.new()
	button.text = btn_name
	if fn_name != null:
		button.connect("pressed",fn_name)
	box.add_child(button)

func _el_test_random():
	var r := RandomNumberGenerator.new();
	r.randomize()
	var rn = floor(ceil(r.randi())) % 11
	print(rn)
	pass
