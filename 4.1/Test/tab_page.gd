extends RefCounted
class_name TabPage

var _node:Node
var tab_container:TabContainer
var scroll_container:ScrollContainer
var current_container

var tabs:Dictionary = {}
var tab_containers:Dictionary = {}

var page = 5
var limit = 0

func _init(node:Node = null):
	_node = node
	setup()
	
func setup():
	create_tab(str(limit))
	set_full_rect()

func set_full_rect():
	var node_class = _node.get_class()
	if node_class == "Control":
		tab_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT,Control.PRESET_MODE_KEEP_SIZE)
	elif node_class.ends_with("Container"):
		_node.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT,Control.PRESET_MODE_KEEP_SIZE)
		tab_container.size_flags_vertical = Control.SIZE_EXPAND_FILL

func get_limit() -> String:
	return str(limit)

func get_scroll_page(limit:int = -1):
	var _limit:String = get_limit()
	if limit > -1:
		_limit = str(limit)
	return "scroll_{0}".format([_limit])

func get_box_page(limit:int = -1):
	var _limit:String = get_limit()
	if limit > -1:
		_limit = str(limit)
	return "box_{0}".format([_limit])

"""
--Control
 |--TabContainer
  |--ScrollContainer
"""
func create_tab(tab_name:String):
	if not tab_container:
		tab_container = TabContainer.new()
	
	scroll_container = ScrollContainer.new()
	scroll_container.name = get_scroll_page()
	tabs[get_scroll_page()] = 1
	
	tab_container.add_child(scroll_container)
	add_box_container(true)
	_node.add_child(tab_container)

"""
--Control
 |--TabContainer
  |--ScrollContainer
   |--(V)(H)BoxContainer
"""
func add_box_container(is_vert:bool = false) -> TabPage:
	var box:BoxContainer = BoxContainer.new()
	box.vertical = is_vert
	var _name = get_box_page()
	box.name = _name
	tab_containers[_name] = 1
	current_container = _name
	scroll_container.add_child(box)
	var _box_node := scroll_container.get_node(_name) as BoxContainer
	_box_node.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_box_node.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	return self

func get_container(cname:String = "") -> TabPage:
	var _cname = current_container
	if cname:
		_cname = cname
	var _box_node := scroll_container.get_node(_cname) as BoxContainer
	return self

"""
--Control
 |--TabContainer
  |--ScrollContainer
   |--(V)(H)BoxContainer
	|-- (your nodes)
"""
func add_node(node:Node):
	if not node:
		return
		
	var scroll := tab_container.get_node_or_null(get_scroll_page()) as ScrollContainer
	if not scroll:
		return
	
	var box := pagination(scroll)
	if not box:
		return
	box.add_child(node,true)

func add_node_position(btn_name:String, node:Node):
	if not node:
		return
	var added_node
	var scroll
	var box
	for i in range(0, limit):
		scroll = tab_container.get_node_or_null(get_scroll_page(i)) as ScrollContainer
		box = scroll.get_node_or_null(get_box_page(i)) as BoxContainer
		if not scroll or not box:
			return
		var target = box.get_node_or_null(btn_name) as Node
		if not target:
			continue
		target.add_sibling(node)

func pagination(tab:ScrollContainer) -> BoxContainer:
	var _limit = str(limit)
	var box := tab.get_node_or_null(current_container) as BoxContainer
	if not box:
		return
	var children_len := box.get_child_count() as int
	
	if children_len + 1 >= page:
		limit += 1
		create_tab(_limit)
	return box




