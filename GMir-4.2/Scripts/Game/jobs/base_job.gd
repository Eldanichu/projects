extends RefCounted
class_name BaseJob

enum JOB {
	Wizard = 1,
	Taos = 2,
	Warrior = 0
}

var atk_g:Dictionary = {
	"dc_base":14,
	"dc_acc":0.43,
	"dcc_base":21,
	"dcc_acc":0.35,
}

const hp_const = 14;
const mp_const = 13;
const exp_const = 14
const exp_factor = 11

var job:JOB
var properties:BaseProperties

func _init(job_:JOB):
	properties = PlayerProperties.new()
	job = job_

func get_max_exp() -> void:
	var level = properties.level
	
	var time:int = level * 2 + 5
	var exp_value:int = level * ( exp_const * exp_factor ) * time
	properties.expv_max = exp_value

func calculate() -> void:
	get_max_exp()

func dc_growth(level:int):
	var dc_acc = 0.3 * (atk_g.dc_base + level) * (atk_g.dc_acc / (1 + properties.dc - 1))
	var dcc_acc = 0.5 * (atk_g.dcc_base + level) * atk_g.dcc_acc / (1 + properties.dcc - 1)
	properties.dcc = (N.I2F(properties.dcc) + N.I2F(dcc_acc))
	properties.dc = (N.I2F(properties.dc) + N.I2F(dc_acc))
