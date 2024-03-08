extends Control

var count = 0
var label_value = 0

@onready var file_select = %file_select
@onready var prg_cup := $tab_container/s1/v_box_container/v_box_container2/prg_cup
@onready var tree = %tree

var hp = 0:
	set(value):
		var ov = hp
		hp = value
		_set_hp(ov,value)

class TableBuilder:
	
	var _tree:Tree
	var _body:TreeItem;
	var _column_size:int = 0
	var _col_prop:Dictionary = {}
	var _columns:Array = []
	var _data:Array = []
	
	func _init(treeNode:Tree):
		_tree = treeNode
		_body = _tree.create_item()
		_tree.hide_root = true
		
	func add_row(row:Dictionary):
		var _row = _tree.create_item(_body)
		for col_index in _col_prop:
			var prop = _col_prop[col_index]
			if prop in row:
				var value = str(row[prop])
				_row.set_text(col_index,value)

	func set_columns(columns:Array):
		_columns = columns
		_calculate_columns()
		_setup_columns()

	func set_data(data:Array):
		_data = data
		_setup_rows()
	
	func _calculate_columns():
		_column_size = len(_columns)
		_tree.columns = _column_size
	
	func _setup_columns():
		var _cols := _columns
		var index = 0
		for col in _cols:
			_tree.set_column_title(index,col["label"])
			_col_prop[index] = col["prop"]
			index = index + 1

	func _setup_rows():
		if not len(_column_size):
			return
		var _rows = _data
		var index = 0
		for _row in _rows:
			add_row(_row)
			index = index + 1

func _ready():
	var table:TableBuilder = TableBuilder.new(tree)
	table.set_columns([
		{"label":"#1","prop":"a"},
		{"label":"#2","prop":"b"},
		{"label":"#3","prop":"c"},
	])
	table.set_data([
		{"b":63453,"a":1,}
	])
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
	var n = NumberUtil.apply_percentages(100,[95,50])
	print(n)
	#print(get_dname("鹿002"))
	#file_select.show()
#
	#file_select.file_selected.connect(_file_selected)
	pass

func _file_selected(path:String):
	async_importer(path)

func async_importer(path):
	var reader = CsvReader.new()
	reader.file_path = path
	reader.open_file()
	dbc.open()
	for row in reader.data:
		dbc.import_monster(row["Name"],{
			"NAME":row["Name"],
			"DNAME":get_dname(row["Name"]),
			"HP":row["HP"],
			"MP":row["MP"],
			"ATK":row["DcMax"],
			"DEF":row["AC"],
			"AGI":row["Hit"],
			"ATKSPD":row["Attack_SPD"],
		})
	dbc.close()

func get_dname(str:String):
	var reg = RegEx.new()
	reg.compile("[0-9]+$")
	var s = reg.search(str)
	if s == null:
		return str
	var matched_str = s.get_string()
	var replaced = str.replace(matched_str,"")
	return replaced
	
func _on_btn_cpu_pressed():
	#prg_cup.set_process_ex(false)
	prg_cup.timer.set_time_scale(0.5)
