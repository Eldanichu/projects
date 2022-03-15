extends Node2D

var data:Database = Database.new()

func _ready() -> void:
  Logger.debug('ready')
  pass

func _exit_tree() -> void:
  data.queue_free()
