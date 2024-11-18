extends Control

signal arrive_at(destination)

@onready var animation = $Animation

var current_destination


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.connect("animation_finished", Callable(self, "_on_animation_finished"))


func home_to_park():
	current_destination = "park"
	show()
	animation.play("home_to_park")
	
	
func park_to_home():
	current_destination = "home"
	show()
	animation.play("park_to_home")


func _on_animation_finished():
	emit_signal("arrive_at", current_destination)
	current_destination = null
	hide()
