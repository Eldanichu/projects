extends BaseJob
class_name TaosClass

const stats_ratio:Dictionary = {
	"hp_base":60,
	"hp_acc":25,
	"mp_base":5,
	"mp_acc":8,
	"mp_rate":22
}

func _init():
	super(JOB.Taos)

func calculate() -> void:
	var level = properties.level
	super()
	properties.hp_max = hp_const + (int(level / stats_ratio.hp_base + stats_ratio.hp_acc) * level);
	properties.mp_max = round(mp_const + (int(level / stats_ratio.mp_base + stats_ratio.mp_acc) * stats_ratio.mp_rate * level))
