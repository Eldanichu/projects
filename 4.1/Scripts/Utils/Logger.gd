extends Node
class_name Log

class CLog:
	
	func _init():
		pass


static func d(callable:Callable):
	print(callable.get_method())
	get_stack()
	pass
