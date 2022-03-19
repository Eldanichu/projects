extends Node
class_name CustomClass

export var a:String = 'this is public';

var _a:String = 'this is private a' setget set_a,get_a;

func out():
    print(a)

func get_a():
    return _a;
    
func set_a(a):
    pass

func _exit_tree():
  queue_free();
