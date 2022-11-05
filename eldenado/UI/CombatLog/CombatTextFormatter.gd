extends Node
class_name CombatTextFormatter

const LogType:Dictionary = {
  TAKEN_DAMAGE = "token_damage",
  MAKE_DAMAGE = "make_damage",
  GET_ITEM = "get_item",
  SELL_ITEM = "sell_item",
  ITEM_LOSS = "item_loss",
  SKILL_READY = "skill_ready",
  SKILL_COOLDOWN = "skill_cooldown",
  SKILL_CAST = "skill_cast"
 }

var type:String = ""
var format_text:String = ""
var format_object:Dictionary = {}
var text_res:String = ""

func set_text(text:String) -> CombatTextFormatter:
  format_object = {}
  format_text = text
  return self

func set_text_kv(from,to) -> CombatTextFormatter:
  format_text = ""
  format_object = {
      "from":from,
      "to" : to
   }
  return self

func set_formatter(formatter) -> CombatTextFormatter:
  type = formatter
  return self

func invoke() -> void:
  if !type:
    printerr('type is not defined')
    return
  if has_method(type):
    call(type)
  else:
    printerr('there is no type of formatter',type)

func skill_cooldown() -> void:
  var ct = CombatText.new(format_text)
  ct.color_text('#f00')
  var _str = "技能冷却剩于{value}秒".format({"value":ct.toString()})
  ct.queue_free()
  text_res = _str

func make_damage() -> void:
  if not is_object():
    text_res = ""
    return
  var from = CombatText.new(format_object.from)
  var to = CombatText.new(format_object.to)
  from.color_text('#f00')
  to.color_text('#0f0')
  var _str = "你对{from}造成{to}点伤害".format({"from":from.toString(),"to":to.toString()})
  from.queue_free()
  to.queue_free()
  text_res = _str

func get_string() -> String:
  invoke()
  return text_res

func is_object() -> bool:
  return ("from" in format_object) and ("to" in format_object) and format_text == ""
