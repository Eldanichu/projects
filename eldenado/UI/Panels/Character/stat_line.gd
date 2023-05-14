extends MarginContainer

onready var stat_name := $"%stat_name"
onready var stat_value := $"%stat_value"

var line:Dictionary = {
	"name":"",
	"value":""
}

func _process(delta):
	stat_name.text = str(line.name)
	stat_value.text = str(line.value)
