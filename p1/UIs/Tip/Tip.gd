class_name Tip
extends Control

export var Title:String = "unnamed item"
export var Gold:String = "-"
export var Position:Vector2 = Vector2(0,0)
export var BackgroundColor:Color = Color.gray

onready var tip_title := $col_1/row_1/margin_container/name;
onready var tip_gold := $col_1/row_1/margin_container_2/gold;
onready var bg_color := $bg_color;


func _ready():
	"""
	bg_color.color = BackgroundColor;
	tip_gold.text = Gold;

	"""
	

func _process(delta):
	rect_position = Position
	tip_title.text = Title;
	update();

func _exit_tree():
	queue_free();
