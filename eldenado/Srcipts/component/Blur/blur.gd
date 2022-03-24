extends TextureRect

export(float,0,5) var blur_amount = 5.0

func _enter_tree() -> void:
  get_material().set_shader_param("blur_amount",blur_amount)

func _process(delta: float) -> void:
  get_material().set_shader_param("blur_amount",blur_amount)
