extends Node
class_name CombatText

var formats:Array = []
var text_result:String

func _init(text:String = "") -> void:
	self.text_result = text

func color_text(color:String) -> CombatText:
	#  "[color={color}]"
	append_format("color", color)
	return self

"""
this method requires set font to RichText
"""
func bold_text() -> CombatText:
	append_format("b")
	return self

"""
this method requires set font to RichText
"""
func italics_text() -> CombatText:
	append_format("i")
	return self

func underline_text() -> CombatText:
	append_format("u")
	return self

func img(url:String,width:float,height:float) -> CombatText:
	var _str = "[img={width}x{height}]{url}"
	append_format("img")
	return self

func indent_text(indents:int = 1) -> CombatText:
	append_format("indent",str(indents))
	return self

func toString() -> String:
	self.text_result = resolve_formats()
	return self.text_result

func append_format(type:String,value:String = "") -> void:
	formats.append({"type":type,"value":value})

func get_tag(type:String, value:String = "", end:bool = false) -> String:
	var res = ["["]
	if end:
		res.push_back("/")
	res.push_back(type)
	if value != null and value != "":
		res.push_back("=" + value)
	res.push_back("]")
	var _str = ArrayUtil.join(res)

	return _str

func resolve_formats() -> String:
	var _formats = formats
	var _qs:Array = ["{text}"]
	for f in _formats:
		if f.type == "color":
			_qs.push_front(get_tag(f.type,f.value))
		elif f.type == "indent":
			for i in range(0,int(f.value)):
				_qs.push_front(get_tag(f.type))
				_qs.push_back(get_tag(f.type, "", true))
			continue
		else:
			_qs.push_front(get_tag(f.type))
		_qs.push_back(get_tag(f.type, "", true))
	var _str = ArrayUtil.join(_qs).format({"text":self.text_result})
	return _str

