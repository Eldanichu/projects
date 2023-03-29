extends Control

var delay_timer:CoolDown

signal splash_end()

onready var version:Label = $screen/m_version/bottom/version
onready var author:Label = $screen/m_version/bottom/author

func _ready() -> void:
	setup()

func setup():
	print_debug("current game version->" + Store.game_var.version)

	version.set_text(Store.game_var.version)
	author.set_text(Store.game_var.author)
	delay_timer = CoolDown.new('screen_delay',0.5)
	add_child(delay_timer)
	delay_timer.start()
	yield(delay_timer,"done")
	delay_timer.queue_free();
	print_debug('delay_timer is free')
	emit_signal("splash_end")
	pass
