extends Timer
##
enum ATTACK_STATE {
	IDLE = 0,
	ATTACKING = 1,
	STOP = 2
 }

func _ready() -> void:

	pass


func _on_EnemyAttack_cooldown(value) -> void:

	pass


func _on_EnemyAttack_done(ready) -> void:
	pass


func _on_PlayerAttack_cooldown(value) -> void:
	pass


func _on_PlayerAttack_done(ready) -> void:
	pass
