extends ItemObject
class_name Gear


func _init():
    pass

func spwan_item(item:ItemObject) -> void:
    print('gear spawn')
    print(item.stringify())
