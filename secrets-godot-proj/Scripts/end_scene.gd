extends Control


@onready var letter_scroll = $LetterScroll
@onready var transition = $Transition



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letter_scroll.position = Vector2(0,0)
	letter_scroll.hide()
	
	transition.connect("transition_completed", Callable(self, "_on_letter_open"))
	transition.position = Vector2(0,0)
	transition.hide()
	

func play_scene():
	show()
	transition.start_scene()
	
	
func _on_letter_open():
	letter_scroll.start_scene()

	
