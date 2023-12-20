extends Resource
class_name OM

var value = {
	"key_path":null,
	"from":null,
	"to":null
}

var key_path:
	get:
		return value["key_path"]
var from:
	get:
		return value["from"]
var to:
	get:
		return value["to"]

var ref:Dictionary

func _init(dict:Dictionary):
	ref = dict

func set_v(key, new_value) -> OM:
	if not len(ref.keys()):
		return
	value["key_path"] = key
	
	value["from"] = get_value_from_key_path()
	value["to"] = new_value
	set_value_from_key_path(value["to"]) 
	return self

func parse_key_path(key_path:String) -> Array:
	var keys = key_path.split("/")
	if not len(keys):
		return []
	if keys[0] == '':
		return []
	return keys

func get_value_from_key_path():
	var key_path = value["key_path"]
	var path = parse_key_path(key_path)
	var _value = ref
	var i = 0
	while typeof(_value) == TYPE_DICTIONARY:
		_value = _value[path[i]]
		i = i + 1
	return _value

func set_value_from_key_path(new_value):
	var key_path = value["key_path"]
	var path = parse_key_path(key_path)
	var before
	var _value = ref
	var i = 0
	while typeof(_value) == TYPE_DICTIONARY:
		before = _value
		_value = _value[path[i]]
		i = i + 1
	var last_path = path[len(path) - 1]
	before[last_path] = new_value
