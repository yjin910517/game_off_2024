extends Control


signal transition_completed()


@onready var file_roll = $FileRoll
@onready var letter_control = $LetterControl
@onready var screen = $ColorScreen
@onready var text = $Text
@onready var anime = $AnimationPlayer
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	anime.connect("animation_finished", Callable(self, "_on_fade_out_finished"))
	file_roll.connect("animation_finished", Callable(self, "_on_scroll_finished"))
	letter_control.connect("letter_clicked", Callable(self, "_on_letter_clicked"))
	
	letter_control.hide()
	
	
func start_scene():
	show()
	text.fade_in()
	timer.wait_time = 6
	timer.start()


func _on_timer_timeout():
	anime.play("color_fade")
	file_roll.play("scroll_loop")


func _on_fade_out_finished(anime_name):
	file_roll.play("scroll_to_end")
	text.hide()
	screen.hide()


func _on_scroll_finished():
	letter_control.show_highlight()


func _on_letter_clicked():
	emit_signal("transition_completed")
	hide()
