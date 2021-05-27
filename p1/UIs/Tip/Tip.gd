class_name Tip
extends Control

export var Title:String = "unnamed item"
export var Price:String = "-"
export var Position:Vector2 = Vector2(0,0)
export var BackgroundColor:Color = Color.gray

onready var tip_title := $col_1/row_1/margin_container/name;
onready var tip_price := $col_1/row_1/margin_container_2/price;
onready var bg_color := $bg_color;

func _process(delta):
	update_tip_position();
	update_tip_info();
	update();

func update_tip_info():
	tip_title.text = Title;
	tip_price.text = Price;

func update_tip_position():
	rect_position = Position

func show():
	visible = true;

func hide():
	visible = false;

func _exit_tree():
	queue_free();
