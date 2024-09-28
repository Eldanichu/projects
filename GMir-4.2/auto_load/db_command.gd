extends RefCounted
class_name DBCommand

var db:SQLite = SQLite.new()

func open():
	print("db opened up")
	db.path = "res://Assets/db/Eldanado.db"
	db.open_db()

func close():
	db.close_db()
