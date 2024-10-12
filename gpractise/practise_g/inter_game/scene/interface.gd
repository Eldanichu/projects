extends PanelContainer
class_name CustomInterface

@onready var lv_oper:NumberOperator  = %lv_oper
@onready var lb_hp: CustomLabel = %lb_hp
@onready var lb_mp: CustomLabel = %lb_mp

func _ready() -> void:
	lv_oper.value_change.connect(_on_lv_change)


func _process(_delta: float) -> void:
	pass

func _on_lv_change(v):
	var actor := Actor.new()
	var war = WarClass.new()
	var prop = actor.prop
	prop.lv = v
	war.prop = prop
	war.calc()
	lb_hp.value = war.prop.hp1
	lb_mp.value = war.prop.mp1
