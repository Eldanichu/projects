extends Control

@onready var box = %box
@onready var label = $box/label


var FUNC_PREFIX = "_el_test_"
var count = 0
var label_value = 0

func _ready():
	var funcs = get_current_script_methods()
	handle_methods(funcs)

func get_current_script_methods() -> Array:
	var funcs_list = []
	var funcs = get_method_list()
	for fn in funcs:
		var fn_name:String = fn.name
		if fn_name.begins_with(FUNC_PREFIX):
			funcs_list.append(fn)
	return funcs_list


func handle_methods(funcs:Array):
	for fn in funcs:
		var fn_name:String = fn.name
		var callable = Callable(self,fn_name)
		var btn_name = fn_name.replace(FUNC_PREFIX,"")
		_create_func_buttons(btn_name,callable)

func _create_func_buttons(btn_name:String, fn_name:Callable):
	var button := Button.new()
	button.text = btn_name
	if fn_name != null:
		button.connect("pressed",fn_name)
	box.add_child(button)

func _el_test_randomi(range:int = 1):
	var r := RandomEx.get_instance();
	var rn = r.randomi(1)
	print(rn)

func _el_test_randomf(range:float = 1.0):
	var r := RandomEx.get_instance();
	var rn = r.randomf(1.0)
	print(rn)
	
func _el_test_uid():
	var r := RandomEx.get_instance();
	var rn = r.uid(5, true)
	print(rn)

func _el_test_pick():
	var r := RandomEx.get_instance();
	var rn = r.pick([1,2,3,4,5])
	print(rn)
	
func _el_test_hit():
	var r := RandomEx.get_instance();
	var rn = r.hit(100)
	print(rn)

func _el_test_loot():
	var r := LootTable.get_instance();
	var rn = r.data().get_items()
	print(rn)

func _el_test_connectDB():
	print(dbc.query_mon_drops(1))
	pass
	
func _el_test_PM():
	var dict = {
		"a":1,
		"b":2,
		"c":{
			"c1":null
		}
	}
	var om = OM.new(dict)
	om.set_v("c/c1",5)
	print(om.key_path)
	print(om.from,"--->",dict)
	Damage.new().source(null,DamageType.new().DEFENCE())


func _el_test_animate_number():
	count = count + 10
	TweenValue.new(self) \
	.from(int(label.text)) \
	.to(count) \
	.set_trans(Tween.TRANS_QUINT) \
	.callback(_animate_number) \
	.start()

func _animate_number(value):
	label.text = str(value)
