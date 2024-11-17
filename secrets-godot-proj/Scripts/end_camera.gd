extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enabled = false


func text_to_credit():
	
	enabled = true
	
	var target_position = Vector2(0, 540)  

	# Use a tween to move the camera smoothly
	var tween = create_tween().bind_node(self).set_trans(Tween.TRANS_SINE)
	
	# Set up tween for camera movement from initial to target position
	tween.tween_property(self, "position", target_position, 10)
