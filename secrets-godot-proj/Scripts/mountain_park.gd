extends Node2D


@onready var entry_control = $EntryControl
@onready var picnic_control = $PicnicControl
@onready var bench_control = $BenchControl
@onready var entry_zoom = $EntryZoom
@onready var picnic_zoom = $PicnicZoom
@onready var bench_zoom = $BenchZoom


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
	
	entry_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	entry_zoom.position = Vector2(0,0)
	entry_zoom.hide()

	picnic_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	picnic_zoom.position = Vector2(0,0)
	picnic_zoom.hide()
	
	bench_zoom.connect("trigger_next_highlight", Callable(self, "_on_trigger_next_highlight"))
	bench_zoom.position = Vector2(0,0)
	bench_zoom.hide()
	
	latest_highlight_idx = 0
	

func _on_highlight_clicked(highlight_name):
	
	if highlight_name == "entry":
		entry_zoom.show()
	if highlight_name == "picnic":
		picnic_zoom.show()
	if highlight_name == "bench":
		bench_zoom.show()


func _on_trigger_next_highlight():
	latest_highlight_idx += 1
	var new_highlight = highlight_list[latest_highlight_idx]
	print("move on to ", new_highlight)
	_show_highlight_display(new_highlight)


func _show_highlight_display(highlight_name):
	if highlight_name == "picnic":
		picnic_control.show()
	if highlight_name == "bench":
		bench_control.show()
	if highlight_name == "find":
		print("show cut scene and gadget find scene")
	
