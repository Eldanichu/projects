extends PanelContainer
class_name CustomInterface

@onready var lv_oper:NumberOperator  = %lv_oper
@onready var stat_box: BoxContainer = %stat_box

var actor:Actor

func _ready() -> void:
	lv_oper.value_change.connect(_on_lv_change)
	actor = Actor.new()

func _process(_delta: float) -> void:
	pass

func _on_lv_change(v):
	var actor_class = actor.create_class(Actor.CLASS_TYPE.WAR) as WarClass
	var prop = actor.prop
	prop.lv = v
	actor_class.calc()
	update_stats_from_prop()

func update_stats_from_prop(): 
	var n_stats = stat_box.get_children()
	for n in n_stats:
		var lb = n as CustomLabel
		var s = n.name.replace("lb_","")
		lb.value = actor.prop[s]
