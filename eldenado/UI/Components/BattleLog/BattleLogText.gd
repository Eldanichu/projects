extends Resource
class_name BattleLogText

var formats:Array = []
var text_result:String
var b setget ,bold
var i setget ,italics
var u setget ,underline
var color setget color
var text setget set_text,to_string

func set_text(text):
	self.text_result = str(text)
	return self

func to_string() -> String:
	self.text_result = resolve_formats()
	return self.text_result

func color(color:Color) -> BattleLogText:
	#  "[color={color}]"
	"""
	var color = Color(1, 1, 1, 0.5)
	var s1 = color.to_html()

	# Returns -> "7fffffff"
	"""
	var _c = "#{0}".format([color.to_html()])
	append_format("color", _c)
	return self

"""
this method requires set font to RichText
"""
func bold() -> BattleLogText:
	append_format("b")
	return self

"""
this method requires set font to RichText
"""
func italics() -> BattleLogText:
	append_format("i")
	return self

func underline() -> BattleLogText:
	append_format("u")
	return self

func img(url:String,width:float,height:float) -> BattleLogText:
	var _str = "[img={width}x{height}]{url}"
	append_format("img")
	return self

func indent(indents:int = 1) -> BattleLogText:
	append_format("indent",str(indents))
	return self

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

