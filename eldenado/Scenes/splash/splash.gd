extends Control

signal splash_end()

onready var version:Label = $screen/m_version/bottom/version
onready var author:Label = $screen/m_version/bottom/author

func _ready() -> void:
	setup()

func setup():
	version.set_text(Store.game_var.version)
	author.set_text(Store.game_var.author)
	yield(get_tree().create_timer(0.5),"timeout")
	emit_signal("splash_end")
	pass
