extends RefCounted
class_name StatModfier


var stats:Dictionary = {}
var stats_added:Array = []

func _init():
	pass

func add(key:String,value:int):
	_cache_added_stat(key,value)
	if key in stats:
		stats[key] = value + stats[key]
		return
	stats[key] = value

func remove(key:String):
	var i := len(stats_added) - 1
	var item:Dictionary
	var stat_name:String
	var value:int
	while (i>=0):
		item = stats_added[i]
		stat_name = item["key"]
		value = item["value"]
		stats[stat_name] = stats[stat_name] - value
		stats_added.remove_at(i)
		i = i - 1

func undo(key:String):
	var i := len(stats_added) - 1
	if i < 0:
		return
	var item:Dictionary = stats_added[i]
	var stat_name:String = item["key"]
	var value:int = item["value"]
	stats[stat_name] = stats[stat_name] - value
	stats_added.remove_at(i)

func _cache_added_stat(stat_name:String,value:int):
	stats_added.append({ "key":stat_name, "value":value })
