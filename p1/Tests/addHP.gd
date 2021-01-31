extends Button

signal addStats();
onready var timer = preload("res://Timers/healing.tscn")

func _ready():
    pass
    
func _on_button_pressed():
    emit_signal("addStats");
    var bn = BigNumber.new("123456")
    var t = timer.instance();
    t.setup("t",bn,.1)
    add_child(t);
    t.connect("healing",self,"_on_healing")

func _on_healing(bn:BigNumber):
    bn.minus(1000)
    print(bn.toAA())
