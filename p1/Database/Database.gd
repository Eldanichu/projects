extends Node
class_name Database

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db:SQLite
var db_name = "res://Database/m1"

var monster:Array = []

func _init() -> void:
  db = SQLite.new()
  db.path = db_name
  db.open_db()
  load_monster()
  pass


func load_monster():
  var table_name = "monster"
  db.query("select * from " + table_name + ";")
  
  var rows = db.query_result
  for i in rows.size():
    monster.append(rows[i])
  Logger.debug("result->"+JSON.print(monster))

func get_monster() -> Array:
  return monster
  pass

func close():
  db.close_db()

func _exit_tree() -> void:
  db.close_db()
