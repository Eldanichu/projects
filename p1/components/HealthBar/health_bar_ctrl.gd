extends Control
class_name HealthyCtrl,"res://Assets/Images/ui/00773.png"

onready var hp_bar:TextureProgress = $hp
onready var l_hp:Label = $lhp/l_hp
onready var mp_bar:TextureProgress = $hp/mp

var healing = preload("res://Timers/healing.tscn")

func _ready():
    hp_bar.value = 1
    hp_bar.max_value = 600
    _set_text()


func _on_button_addStats():
    if !_get_healing_timer("t_healing"):
        var _healing = healing.instance();
        _healing.setup("t_healing", 5, .3);
        _healing.connect("healing",self,"_on_healing")
        add_child(_healing)

func _on_healing(val):
    hp_bar.value += val
    _set_text()

func _set_text():
    l_hp.text = "{hp}/{hpmax}".format({"hp":hp_bar.value,"hpmax":hp_bar.max_value})

func _get_healing_timer(t_name):
    var child = get_children();
    for c in child:
        if t_name == c.name:
            return true
    return false
