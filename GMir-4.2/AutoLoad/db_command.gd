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

func query_mon_by(mon_id):
	open()
	var sql = "select * from Monsters where ID = {monId}".format({
		"monId":mon_id
	})
	log.d(sql)
	db.query(sql)
	var row = db.query_result[0]
	log.d(row)
	close()
	return row
	
func query_map_mon_group(map_id):
	open()
	var sql = "select 
				mg.MAP_ID,mg.MON_ID, 
				mon.ID,mon.NAME,mon.DNAME
				from MonsterGroup mg 
				left join Monsters mon on mg.MON_ID = mon.ID
				where mg.MAP_ID = {map_id}".format({
		"map_id":map_id
	})
	log.d(sql)
	db.query(sql)
	var rows = db.query_result
	log.d(rows)
	close()
	return rows

func query_mon_drops(mon_id:int):
	open()
	var sql = "select m.ID,m.DNAME,md.RV,md.WEIGHTS,md.DROPS from Monsters m 
				left join MonsterDrops md on md.MONID = m.ID 
				where m.ID = {mon_id}" \
				.format({"mon_id":mon_id})
	log.d(sql)
	db.query(sql)
	var rows = db.query_result
	log.d(rows)
	close()
	return rows

func import_monster(mon_name:String, row:Dictionary):
	var props = []
	var cols = []
	for key in row:
		props.append("{0}=\'{1}\'".format([key,row[key]]))
		cols.append('\'{0}\''.format([row[key]]))
	
	var sql = "select NAME,DNAME from Monsters where NAME = '{0}'".format([mon_name])
	var rows = db.query_result
	if len(rows):
		var update = "update Monsters set {props} where NAME = '{mon_name}'".format({
			"props":",".join(props),
			"mon_name":mon_name
		})
		db.query(update)
		return
	var insert = "insert into Monsters (NAME,HP,MP,DEF,ATK,AGI) values ({props})".format({
			"props":",".join(cols)
		})
	db.query(insert)



















func _exit_tree():
	close()
