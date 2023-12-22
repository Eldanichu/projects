extends Control

var count = 0
var label_value = 0

@onready var file_select = %file_select

var hp = 0:
	set(value):
		var ov = hp
		hp = value
		_set_hp(ov,value)

class A:
	func _init() -> void:
		print("A init")
		pass
	
	func foo():
		print("foo")

class CB extends A:
	func _init() -> void:
		super()
		print("B init")

	func foo():
		print("foo 2 do first")
		super()
		print("foo 2 do after")

func _ready():
	var b= CB.new();
	b.foo()

	pass

func _set_hp(ov,nv):
	print("before->",ov)
	print("after->",nv)

func _setter_getter_test():
	hp += 2
	pass



func _el_test_randomi():
	var r := RandomEx.get_instance();
	var rn = r.randomi(1)

func _el_test_randomf():
	var r := RandomEx.get_instance();
	var rn = r.randomf(1.0)
	print(rn)

func _el_test_uid():
	var r := RandomEx.get_instance();
	var rn = r.uid(5, true)

func _el_test_pick():
	var r := RandomEx.get_instance();
	var rn = r.pick([1,2,3,4,5])
	print(rn)

func _el_test_hit():
	var r := RandomEx.get_instance();
	var rn = r.hit(40)
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
#	Damage.new().source(null,DamageType.new().DEFENCE())

func _el_test_animate_number():
	count = count + 10
	TweenValue.new(self) \
#	.from(int(label.text)) \
	.to(count) \
	.set_trans(Tween.TRANS_QUINT) \
#	.callback(_animate_number) \
	.start()

func _import_monsters():
	file_select.show()

	file_select.file_selected.connect(_file_selected)
	pass

func _file_selected(path:String):
	var thread = Thread.new()
	thread.start(async_importer.bind(path))
	thread.wait_to_finish()

func async_importer(path):
	var reader = CsvReader.new()
	reader.file_path = path
	reader.open_file()
	dbc.open()
	for row in reader.data:
		dbc.import_monster(row["Name"],{
			"NAME":row["Name"],
			"HP":row["HP"],
			"MP":row["MP"],
			"ATK":row["DcMax"],
			"DEF":row["AC"],
			"AGI":row["Hit"],
		})
	dbc.close()

