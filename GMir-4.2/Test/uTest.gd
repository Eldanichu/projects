extends Control

var count = 0

@onready var file_select = %file_select
@onready var prg_cup := $tab_container/s1/v_box_container/v_box_container2/prg_cup
@onready var tree = %tree
@onready var lbl_gt = %lbl_gt


func _ready():

	pass

func create_table():
	var table:TableBuilder = TableBuilder.new(tree)
	var props = table.get_property_list()
	
	table.set_columns([
		{"label":"#1","prop":"a"},
		{"label":"#2","prop":"b"},
		{"label":"#3","prop":"c"},
	])
	table.set_data([
		{"b":63453,"a":1,}
	])

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


func _el_test_connectDB():
	print(dbc.query_mon_drops(1))
	pass

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
