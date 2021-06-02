class_name Tip
extends Control

export(String) var Title:String = "unnamed item"
export(String) var Price:String = "-"
export(Vector2) var Position:Vector2 = Vector2(0,0)
export(Color) var BackgroundColor:Color = Color.gray

onready var tip_title := $col_1/row_1/margin_container/name;
onready var tip_price := $col_1/row_1/margin_container_2/price;
onready var bg_color := $bg_color;
onready var rich_label := $col_1/row_3/margin_container/rich_label;


func _process(delta):
	if !visible: return;
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
