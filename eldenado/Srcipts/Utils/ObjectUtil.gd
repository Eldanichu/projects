extends Node
class_name ObjectUtil

static func get_ref(obj):
  return weakref(obj).get_ref()

static func is_null(obj):
  if(obj == null):
    return true
  var _ref = get_ref(obj)
  if _ref == null:
    return true
  return false
