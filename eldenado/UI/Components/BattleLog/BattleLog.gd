extends MarginContainer

export var MAX_LINE = 5000

onready var logger = $"%logger"

var format:BattleLogText setget ,get_format
var line_number = 1

func println(text):
	_limit_clear()
	var _text
	if text is BattleLogText:
		_text = text.to_string()
	elif text is String:
		_text = text

	var line_text = "{0}\n".format([_text])
	logger.append_bbcode(line_text)
	ln_inc()

func get_format() -> BattleLogText:
	return BattleLogText.new()

func clear()->void:
	logger.clear()
	ln_reset()

func ln_reset():
	line_number = 1

func ln_inc():
	line_number = line_number + 1

func _limit_clear()->void:
	if line_number >= MAX_LINE:
		clear()
