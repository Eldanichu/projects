extends Resource
class_name ItemIcons

var items = {
    "i28":preload("res://Assets/Images/Item/00028.png"),
    "i29":preload("res://Assets/Images/Item/00029.png"),
    "i83":preload("res://Assets/Images/Item/00083.png"),
    "i394":preload("res://Assets/Images/Item/00394.png"),
}

func get_icon(name):
    return items[name]
