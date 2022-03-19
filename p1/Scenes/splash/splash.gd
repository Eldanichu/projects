extends Control

var intro:AnimationPlayer
var outro:AnimationPlayer
var delay_timer:CoolDown

signal splash_end()

func _ready() -> void:
  Logger.debug("current game version->"+Store.global.version)
  intro = $intro
  outro = $outro
  setup()
  pass

func setup():
  intro.play('fade_in')
  yield(intro,"animation_finished")
  Logger.debug('intro is done')
  delay_timer = CoolDown.new('screen_delay',2)
  add_child(delay_timer)
  delay_timer.start()
  yield(delay_timer,"done")
  delay_timer.queue_free();
  Logger.debug('delay_timer is free')
  Logger.debug('starting outro')
  outro.play('fade_out')

  yield(outro,"animation_finished")
  emit_signal("splash_end")
  pass

