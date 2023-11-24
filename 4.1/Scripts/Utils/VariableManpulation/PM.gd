extends Resource
class_name PM

var value = {
	"from":null,
	"to":null
}

var from:
	set(new_value):
		set_from(new_value)
	get:
		return value["from"]

var to:
	set(new_value):
		set_to(new_value)
	get:
		return value["to"]

func _init(p_from):
	value['from']
	pass
	
func set_from(new_value) -> PM:
	value["from"] = new_value
	return self

func set_to(new_value) -> PM:
	value["to"] = new_value
	return self
