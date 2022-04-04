extends Node
class_name Json

static func parse(json_str:String) -> Dictionary:
  return parse_json(json_str)

static func stringify(json_object:String) -> String:
  return to_json(json_object)

static func is_json(json_str:String) -> bool:
  var msg:String = validate_json(json_str)
  return true if msg == "" else false
