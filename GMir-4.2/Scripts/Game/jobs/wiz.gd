extends BaseJob
class_name WizClass

const stats_ratio:Dictionary = {
	"hp_base":150,
	"hp_acc":18,
	"mp_base":5,
	"mp_acc":2,
	"mp_rate":22,
	"dc_base":14,
	"dc_acc":0.43,
	"dcc_base":21,
	"dcc_acc":0.35,
}

func _init():
	super(JOB.Wizard)

func calculate() -> void:
	var level = properties.level
	super()
	hp_growth(level)
	dc_growth(level)

func hp_growth(level:int):
	properties.hp_max = hp_const + (int(level / stats_ratio.hp_base + stats_ratio.hp_acc) * level);
	properties.mp_max = round(mp_const + (int(level / stats_ratio.mp_base + stats_ratio.mp_acc) * stats_ratio.mp_rate * level))

func dc_growth(level:int):
	var dc_acc = 0.3 * (stats_ratio.dc_base + level) * (stats_ratio.dc_acc / (1 + properties.dc - 1))
	var dcc_acc = 0.5 * (stats_ratio.dcc_base + level) * stats_ratio.dcc_acc / (1 + properties.dcc - 1)
	properties.dcc = (N.I2F(properties.dcc) + N.I2F(dcc_acc))
	properties.dc = (N.I2F(properties.dc) + N.I2F(dc_acc))
