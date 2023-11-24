extends RefCounted
class_name State

var value:int = IDEL()

func _init():
	value = IDEL()

func IDEL():
	value = 0x01
func IN_BATTLE():
	value = 0x02
func NO_MANA():
	value = 0x55
func CAN_ATTACK():
	value = 0x31
func CASTING():
	value = 0x32
func DEATH():
	value = 0x99
