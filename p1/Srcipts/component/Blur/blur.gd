extends TextureRect

export(float,0,5) var blur_amount = 0.0


func _process(delta: float) -> void:
  get_material().set_shader_param("blur_amount",blur_amount)
