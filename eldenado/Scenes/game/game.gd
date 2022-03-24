extends Node2D

func _ready() -> void:
  Logger.debug('ready')
  pass

func _exit_tree() -> void:
  queue_free()
  pass
