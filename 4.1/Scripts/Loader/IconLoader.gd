extends Resource
class_name IconLoader

const ICON_STATS:Array = [
	"res://Assets/Icons/s2.tres",
	"res://Assets/Icons/s3.tres",
	"res://Assets/Icons/s4.tres",
	
	
	"res://Assets/Icons/s5.tres",
	"res://Assets/Icons/s9.tres",
	"res://Assets/Icons/s11.tres",
	"res://Assets/Icons/s10.tres",
	
	"res://Assets/Icons/s2#r.tres",
	"res://Assets/Icons/s5#r.tres",
	"res://Assets/Icons/s9#r.tres",
	"res://Assets/Icons/s11#r.tres",
	"res://Assets/Icons/s10#r.tres",
	
	"res://Assets/Icons/s8.tres",
	"res://Assets/Icons/s7.tres",
]

static func get_resource(stat_icon_index:int) -> Dictionary:

	var path:String = ICON_STATS[stat_icon_index]
	var res = null
	var meta = Color.WHITE
	if path.contains("#r"):
		res = ResourceLoader.load(path.replace("#r",""))
		meta = res.get_meta("rColor")
	else:
		res = ResourceLoader.load(path)
	return {
		"icon":res,
		"meta":meta
	}
