extends Control

func _ready():
  var g := Globals.new();
  for i in range(1,200):
    print(i,"-->",g.getClassHpMp(i,0).max_hp)
