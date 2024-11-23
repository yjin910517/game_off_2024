extends Node2D


signal effect_completed(anime_name)


@onready var movements = $Movements


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	movements.connect("animation_finished", Callable(self, "_on_animation_finished"))


func move_to(destination):
	show()
	movements.play(destination)


func _on_animation_finished(anime_name):
	hide()
	emit_signal("effect_completed", anime_name)
