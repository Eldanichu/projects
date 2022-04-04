extends Node
class_name CombatText

var texts:Array
var text_result:String

enum LogType {
  TAKEN_DAMAGE = 0,
  DAMAGE = 1,
  GET_ITEM = 2,
  ITEM_LOSS = 3
 }

func _init() -> void:
  self.texts = []
  self.text_result = ""

func color_text(text,color:String) -> String:
  var _str = "[color={color}]{text}[/color]".format({"color":color,"text":str(text)})
  return _str

func bold_text(text) -> String:
  var _str = "[b]{text}[/b]".format({"text":str(text)})
  return _str

func italics_text(text) -> String:
  var _str = "[i]{text}[/i]".format({"text":str(text)})
  return _str

func underline_text(text) -> String:
  var _str = "[u]{text}[/u]".format({"text":str(text)})
  return _str

func indent_text(text,indent:int = 1) -> String:
  var indents:Array = []
  for i in range(0,indent):
    indents.append("[indent]")

  indents.append("{text}")

  for i in range(0,indent):
    indents.append("[/indent]")

  var _text = ArrayUtil.join(indents)
  var _str = _text.format({"text":str(text)})
  return _str

func img(url:String,width:float,height:float) -> String:
  var _str = "[img={width}x{height}]{url}[/img]".format(
      {
        "url":url,
        "width":width,
        "height":height
      }
    )
  return _str

func append(text:String) -> CombatText:
  self.texts.append(text)
  return self

func formatter(type:int,messages:Array) -> String:
  var msg:String = ""
  var _dmg = str(messages[1])
  match type:
    LogType.DAMAGE:
      msg = "你对 {object} 造成了 {damge} 点伤害".format({"object":messages[0],"damge":_dmg})
    LogType.TAKEN_DAMAGE:
      msg = "{object}对你  造成了 {damge} 点伤害".format({"object":messages[0],"damge":_dmg})
  return msg


func toString() -> String:
  self.text_result = ArrayUtil.join(texts)
  return self.text_result
