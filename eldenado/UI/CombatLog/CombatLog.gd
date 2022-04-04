extends RichTextLabel

onready var logger = $"."

func _ready() -> void:
  pass


func println(combat_text:CombatText):
  var _code = combat_text.toString()
  logger.append_bbcode("{code}\n".format({"code":_code}))

