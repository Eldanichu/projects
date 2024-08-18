extends BaseJob
class_name WarClass

const stats_ratio:Dictionary = {
	"hp_base":40,
	"hp_acc":45,
	"hp_cc":20,
	"mp_base":35
}

func _init():
	super(JOB.Warrior)

func calculate() -> void:
	var level = properties.level
	super()
	properties.hp_max = hp_const + (int(level / stats_ratio.hp_base + stats_ratio.hp_acc + level / stats_ratio.hp_cc) * level)
	properties.mp_max = round(level * stats_ratio.mp_base)
	
	
	
	
