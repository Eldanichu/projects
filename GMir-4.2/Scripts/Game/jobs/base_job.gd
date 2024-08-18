extends RefCounted
class_name BaseJob

enum JOB {
	Wizard = 1,
	Taos = 2,
	Warrior = 0
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
	
	var time:int = level * 0.93 + 5
	var exp_value:int = level * ( exp_const * exp_factor ) * time
	properties.expv_max = exp_value

func calculate() -> void:
	get_max_exp()
