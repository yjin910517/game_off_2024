extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# fade in and out effect with shader
func fade_in():
	show()
	var tween = create_tween()
	material.set_shader_parameter("fade_amount", 0.0)
	tween.tween_property(material, "shader_parameter/fade_amount", 1.0, 1.2)
