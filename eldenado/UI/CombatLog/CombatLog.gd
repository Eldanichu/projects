extends RichTextLabel

export var MAX_LINE = 500

onready var logger = $"."

var line_number = 1

func _ready() -> void:
	pass


func println(combat_text:CombatText):
	clear_screen()
	var _code = combat_text.toString()
	logger.append_bbcode("{code}\n".format({"code":_code}))
	line_number = line_number + 1

func println_code_string(combat_text_string:String):
	clear_screen()
	var _code = combat_text_string
	logger.append_bbcode("{code}\n".format({"code":_code}))
	line_number = line_number + 1

func clear_screen()->void:
	if line_number >= MAX_LINE:
		clear()
