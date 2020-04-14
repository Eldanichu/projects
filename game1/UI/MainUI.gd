extends Control

onready var gear=$gears


func _on_opts_display_bag(vis) -> void:
	pass

func _on_opts_display_charp(vis) -> void:
	if gear.visible:
		gear.visible=!vis
	else:
		gear.visible = vis
