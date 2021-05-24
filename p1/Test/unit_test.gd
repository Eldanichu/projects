extends Control


func _ready() -> void:
    pass


func _on_class_pressed() -> void:
    var sc = CustomClass.new();
    sc._a = 'ddd'
    callParam(sc)


func callParam(b:CustomClass):
    print(b.a)
    print(b._a)
