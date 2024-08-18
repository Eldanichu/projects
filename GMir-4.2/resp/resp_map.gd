extends DBCommand
class_name RESPMap

func query_maps():
	open()
	var sql = "select * from Maps"
	db.query(sql)
	var row = db.query_result
	close()
	return row
	










