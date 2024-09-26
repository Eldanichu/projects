extends BoxContainer
class_name ARow

signal on_click(this)
signal on_input(this,input_str)

@onready var c_text: TextEdit = %c_text
@onready var c_delete: Button = %delete

var text:String = "":
	set(value):
		if not c_text:
			return
		c_text.call_deferred("set_text",str(value))

func _ready() -> void:
	c_text.text_changed.connect(_on_c_text_text_changed)

func _on_delete_button_up() -> void:
	emit_signal("on_click",self)


func _on_c_text_text_changed() -> void:
	var regex = RegEx.new()
	var botext = regex.compile("[^-0-9.]")
	var _t = c_text.text
	for r in regex.search_all(_t):
		c_text.text = c_text.text.replace(r.get_string(), "")
	emit_input()

func emit_input():
	var _text = c_text.text
	if _text == null or _text == "":
		on_input.emit(self,0)
	else:
		on_input.emit(self,_text)
	
	
