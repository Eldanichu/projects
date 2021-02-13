extends Sprite

onready var spr2 = $"."
onready var spr2_click = $texture_button
onready var spr2_mask = $texture_progress
onready var spr2_cd = $cd

signal skill_click

var timer:Timer;
export(float) var SKILL_CD = 6

func _ready():
    spr2_mask.value = 0
    spr2_click.connect("pressed",self,"spr_click")
    
    if(!timer):	
        timer = Timer.new();
        add_child(timer);
        timer.connect("timeout",self,"mask_tmout")
        timer.wait_time = SKILL_CD;

func _process(delta):
    spr2_cd.text = "%0.1f" % [timer.time_left]
    spr2_mask.value = (timer.time_left / SKILL_CD) * 100

func spr_click():
    if(timer.is_stopped()): 
        timer.start();
        emit_signal("skill_click")
        return;

func mask_tmout():
    print("time out")
    timer.stop();
