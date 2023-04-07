extends Control

export(String) var placeholder = "S"

onready var _placeholder := $"%label"

func _ready() -> void:
	_placeholder.text = placeholder
