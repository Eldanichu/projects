extends BaseJob
class_name WizClass

const stats_ratio:Dictionary = {
	"hp_base":150,
	"hp_acc":18,
	"mp_base":5,
	"mp_acc":2,
	"mp_rate":22
}

func _init():
	super(JOB.Wizard)
	atk_g = {
		"dc_base":13,
		"dc_acc":0.38,
		"dcc_base":19,
		"dcc_acc":0.30,
	}

func calculate() -> void:
	var level = properties.level
	super()
	hp_growth(level)
	dc_growth(level)

func hp_growth(level:int):
	properties.hp_max = hp_const + (int(level / stats_ratio.hp_base + stats_ratio.hp_acc) * level);
	properties.mp_max = round(mp_const + (int(level / stats_ratio.mp_base + stats_ratio.mp_acc) * stats_ratio.mp_rate * level))

