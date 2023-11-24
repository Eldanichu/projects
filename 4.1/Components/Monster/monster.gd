extends GameObject
class_name Monster

@onready var m_name = %m_name
@onready var m_hp = %m_hp
@onready var m_lv = %m_lv

var actor:GameActor

func _ready():
	setup()
	pass 


func _process(delta):
	pass

func setup():
	actor = GameActor.new();
	pass
