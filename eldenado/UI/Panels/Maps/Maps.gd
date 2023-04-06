extends Control

signal map_entering(map)

export(Array) var MapData = []

onready var map_panel = $"%map_panel"
onready var tabs := $"%tabs"

class MapButton:
	var parent:Node
	var target:Node
	var name:String
	var ref:String
	var level:int
	var event_func:String

	func _init(
		_name:String,
		_event_obj:Node,
		_add_to:Node,
		_event_func:String
	) -> void:
		name = _name
		parent = _event_obj
		target = _add_to
		event_func = _event_func
		ref = ""
		level = -1

	func set_ref(_ref):
		ref = _ref
		return self

	func set_level(_level):
		level = int(_level)
		return self

	func _new():
		var _btn = Button.new()
		_btn.text = name
		_btn.connect("pressed", parent, event_func, [self])

		target.add_child(_btn)

func _ready() -> void:
	var map_tab_name := tr("TAG_MAPS").split("_")

	for tab_index in range(tabs.get_tab_count()):
		tabs.set_tab_title(tab_index, map_tab_name[tab_index])

func load_data():
	var _size = MapData.size()
	if !_size:
		return
	for m_btn in MapData:
		MapButton.new(
			m_btn.name,
			self,
			map_panel,
			"map_click"
		) \
		.set_ref(m_btn.ref) \
		.set_level(m_btn.level) \
		._new()

func map_click(e):
	emit_signal("map_entering", e)
