extends Node
class_name DBCommand

var db:SQLite = SQLite.new()

func open():
	print("db opened up")
	db.path = "res://Assets/db/Eldanado.db"
	db.open_db()

func close():
	db.close_db()

func query_items() -> Array:
	open()
	db.query("select * from Item")
	var rows:Array = db.query_result
	close()
	return rows

func query_mon_drops(mon_id:int):
	open()
	var sql = "select m.ID,m.DNAME,md.RV,md.WEIGHTS,md.DROPS from Monsters m 
				left join MonsterDrops md on md.MONID = m.ID 
				where m.ID = {mon_id}" \
				.format({"mon_id":mon_id})
	db.query(sql)
	var rows = db.query_result
	return rows
	pass























func _exit_tree():
	close()
