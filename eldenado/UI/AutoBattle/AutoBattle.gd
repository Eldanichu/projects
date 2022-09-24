extends Timer

var a_enemy
var a_player

onready var i_player:TweenProgress = get_node("PlayerIndicator")
onready var i_enemy:TweenProgress = get_node("EnemyIndicator")

enum ATTACK_STATE {
  IDLE = 0,
  ATTACKING = 1,
  STOP = 2
 }

var enemy:Dictionary = {
  "state":0
 }

var player:Dictionary = {
  "state":0
 }

func _ready() -> void:
  a_enemy = CoolDown.new("enemy",5)
  a_enemy.idle = true
  a_player= CoolDown.new("player",5)
  a_enemy.connect("cooldown",self,"_on_EnemyAttack_cooldown")
  a_enemy.connect("done",self,"_on_EnemyAttack_done")
  i_enemy.v_max = 5
  i_enemy.t_max = 5
  a_player.start()
  add_child(a_enemy)
  add_child(a_player)
  pass


func _on_EnemyAttack_cooldown(value) -> void:
  i_enemy.t_val = float(value)
  i_enemy.v_val = float(value)
  pass


func _on_EnemyAttack_done(ready) -> void:
  a_enemy.restart()
  pass


func _on_PlayerAttack_cooldown(value) -> void:
  pass


func _on_PlayerAttack_done(ready) -> void:
  pass
