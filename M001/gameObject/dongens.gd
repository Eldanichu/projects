extends Tabs

onready var map = $levelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	createDongensButton();
	

func createDongensButton() ->void:
	var btn;
	for i in range(1,10):
		btn = Button.new();
		btn.text = str(i);
		btn.connect("button_up",self,"dongenClick",[btn.text])
		map.add_child(btn)


func dongenClick(e):
	
	var rnd = RandomNumberGenerator.new();
	rnd.randomize();
	var num = rnd.randi_range(0.0,3.0)
	
	print(num)
