extends Node2D


signal navigate_to_home(item_found)


@onready var home_nav = $HomeNav
@onready var entry_control = $EntryControl
@onready var picnic_control = $PicnicControl
@onready var bench_control = $BenchControl
@onready var entry_zoom = $EntryZoom
@onready var picnic_zoom = $PicnicZoom
@onready var bench_zoom = $BenchZoom
@onready var find_zoom = $FindZoom


var item_found
var highlight_list = ["entry", "picnic", "bench", "find"]
var latest_highlight_idx


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entry_control.connect("highlight_clicked", Callable(self, "_on_highlight_clicked"))
	picnic_control.connect("highlight_clicked", Callable(self, "_on_highlight_clicked"))
	bench_control.connect("highlight_clicked", Callable(self, "_on_highlight_clicked"))
	
	entry_control.set_highlight_name("entry")
	picnic_control.set_highlight_name("picnic")
	picnic_control.hide()
	bench_control.set_highlight_name("bench")
	bench_control.hide()
	
	home_nav.connect("navigation_clicked", Callable(self, "_on_navigation_clicked"))
	
	entry_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	entry_zoom.position = Vector2(0,0)
	entry_zoom.hide()

	picnic_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	picnic_zoom.position = Vector2(0,0)
	picnic_zoom.hide()
	
	bench_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	bench_zoom.position = Vector2(0,0)
	bench_zoom.hide()
	
	find_zoom.connect("park_item_found", Callable(self, "_on_park_item_found"))
	find_zoom.position = Vector2(0,0)
	find_zoom.hide()
	
	latest_highlight_idx = 0
	item_found = false
	

func _on_navigation_clicked():
	emit_signal("navigate_to_home", item_found)
	hide()


func _on_park_item_found():
	
	# redirect bench highlight to a new display page
	bench_control.set_highlight_name("bench_after")
	
	# bring item home
	item_found = true
	emit_signal("navigate_to_home", item_found)
	hide()


func _on_highlight_clicked(highlight_name):
	
	if highlight_name == "entry":
		entry_zoom.show()
	if highlight_name == "picnic":
		picnic_zoom.show()
	if highlight_name == "bench":
		bench_zoom.show()
	if highlight_name == "bench_after":
		bench_zoom.show()
		


func _on_trigger_next_highlight():
	latest_highlight_idx += 1
	var new_highlight = highlight_list[latest_highlight_idx]
	_show_highlight_display(new_highlight)


func _show_highlight_display(highlight_name):
	if highlight_name == "picnic":
		picnic_control.show()
	if highlight_name == "bench":
		bench_control.show()
	if highlight_name == "find":
		find_zoom.show()
	
