extends DBCommand
class_name RESPItem

func query_items() -> Array:
	open()
	db.query("select * from Item")
	var rows:Array = db.query_result
	close()
	return rows

func import_item(mon_name:String, row:Dictionary):
	var sb := SqlBuilder.new(row)
	#var sql = "select NAME from Item where NAME = '{0}'".format([mon_name])
	#db.query(sql)
	#var rows = db.query_result
	#if len(rows):
		#var update = "update Item set {props} where NAME = '{mon_name}'".format({
			#"props":",".join(props),
			#"mon_name":mon_name
		#})
		#print(update)
		#db.query(update)
		#return
	var insert = "insert into Item ({columns}) values ({values})".format({
			"columns":sb.get_columns(),
			"values":sb.get_column_values()
		})
	print(insert)
	#db.query(insert)

