extends ScrollContainer

@export var obj:GameObject

@onready var page_stat = %page_stat

var u_props:Dictionary = {}

func _ready():
	cache_prop_ui_nodes()
	update_ui_name()
	
func cache_prop_ui_nodes():
	var lines = page_stat.get_children()
	for col in lines:
		u_props[col.name] = col

func update_ui_name():
	var dict_prop = G.DIC_CHAR_PROP
	for o in dict_prop:
		var item = dict_prop[o]
		var u_name = item["key"]
		u_props[u_name].label = item["label"]
		u_props[u_name].val = "0"

func update_prop_ui():
	var props = obj.properties.prop
	for p in props:
		var prop_value = props[p]
		if not p in G.DIC_CHAR_PROP:
			continue
		var dict_prop = G.DIC_CHAR_PROP[p]
		var dict_key = dict_prop["key"]
		if not dict_key in u_props:
			continue
		var porp_ctrl:UIProperty = u_props[dict_key]
		porp_ctrl.val = str(prop_value)
