extends Node2D

onready var inv = $inv


func _ready():
	inv.connect("slot_click",self,"_on_slot_click");
	
func _on_slot_click(index):
	print("parent node event!->",index)
