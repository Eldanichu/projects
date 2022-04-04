extends Control

onready var combat_log = $combat_log

func _on_append_text_pressed() -> void:
  var combat_text:CombatText = CombatText.new()
  var rnd_num = RandomNumberGenerator.new()
  rnd_num.randomize()
  var damage = rnd_num.randi_range(1,50)
  var _text = combat_text.indent_text(
    combat_text.formatter(
      CombatText.LogType.DAMAGE,
      [
        combat_text.color_text("怪物","#0ff"),
        combat_text.color_text(damage,"#0ff")
      ]
    ), 1
  )

  combat_text.append(_text)

  var join = ArrayUtil.join(["1","2","3"],"-")
  print(join)


  combat_log.println(combat_text)
  combat_text.queue_free()

