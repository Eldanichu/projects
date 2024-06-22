extends GameObject
class_name PlayerObject

var job:BaseJob

func _init(job_type:BaseJob.JOB):
	super()
	create_job(job_type)
	
func create_job(job_type:BaseJob.JOB):
	if job_type == BaseJob.JOB.Wizard:
		job = WizClass.new()
	elif job_type == BaseJob.JOB.Warrior:
		job = WarClass.new()
	elif job_type == BaseJob.JOB.Taos:
		job = TaosClass.new()
	properties = job.properties
	job.calculate()
	level_up()

func level_up():
	super()
	job.get_max_exp()
	job.calculate()
