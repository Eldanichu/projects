extends Resource
class_name GameUtils

static func get_percent(value:float,max_value:float) -> float:
	var b_value:BigNumber = BigNumber.new(str(value))
	var b_max_value:BigNumber = BigNumber.new(str(max_value))

	if(b_max_value.isEqualTo(0)):
		max_value = 1.0
	b_max_value = BigNumber.new(str(max_value))

	var percent = b_value.divide(b_max_value).toFloat()
	return percent * 100

static func set_label_text(value:String,max_value:String, percent:String = "") -> String:
	var b_value:BigNumber = BigNumber.new(value,1)
	var b_max_value:BigNumber = BigNumber.new(max_value,1)
	var s_text_format = ("{value} / {max_value}")
	var oFormat:Dictionary = {}

	if(percent and percent != ""):
		s_text_format = ("{value} / {max_value}  {percent}%")
		oFormat["percent"] = percent

	if(b_value.isLargerThanOrEqualTo(b_max_value)):
		value = max_value
	if(b_value.isLessThanOrEqualTo(0)):
		value = "0"
	b_value = BigNumber.new(value)
	b_max_value = BigNumber.new(max_value)

	var text
#	if(Store.settings.useShortNumber):
#		oFormat["value"] = str(b_value.toAA())
#		oFormat["max_value"]=str(b_max_value.toAA())
#		text = s_text_format.format(oFormat)
#	else:
	oFormat["value"] = str(b_value.toString())
	oFormat["max_value"]=str(b_max_value.toString())
	text = s_text_format.format(oFormat)
	return text

static func set_z_index(control_node:CanvasItem,z_index:int):
	VisualServer.canvas_item_set_z_index(control_node.get_canvas_item(),z_index)

static func quit(node:Node):
	node.get_tree().quit()
