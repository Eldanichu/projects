extends TextureRect
var image = load('res://images/00060.PNG')
func _ready() -> void:
	var sprites := get_children();
	var pos
	var item
	for spr in sprites:
		if spr is Sprite:
			pos = spr.get_child(0).position
			spr.position = pos
			item = _add_gear(load('res://images/00060.PNG'))
			spr.add_child(item)
			print(spr.get_children())
		
func _on_btn_pressed(p:TextureButton) ->void:
	if(!_has_item(p)):return
	p.texture_normal = null
	print("click",p)

func _on_gears_mouse_entered(p:TextureButton) -> void:
	if(!_has_item(p)):return
	print("floating info...",p.name)

func _add_gear(res:Resource) -> TextureButton:
	var btn = TextureButton.new()
	btn.texture_normal = res
	if(btn.texture_normal!=null):
		btn.connect('pressed',self,'_on_btn_pressed',[btn])
		btn.connect('mouse_entered',self,'_on_gears_mouse_entered',[btn])
	return btn
func _has_item(p:TextureButton)->bool:
	return !!p.texture_normal
