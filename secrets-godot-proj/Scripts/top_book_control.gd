extends Control


signal passport_box_found(info_text)
signal show_book_info(info_text)

var info_dataset = [
	"secret box info", # use zero index to store special info text
	"book 1 intro",
	"book 2 intro",
	"book 3 intro",
	"book 4 intro",
	"book 5 intro",
	"book 6 intro",
	"book 7 intro",
]

const secret_box_id = 4

func _ready():
	var book_nodes = get_children()
	for book in book_nodes:
		book.connect("book_clicked", Callable(self, "_on_book_clicked"))


func _on_book_clicked(book_name):
	var book_id = book_name.substr(4).to_int()
	if book_id == secret_box_id:
		emit_signal("passport_box_found", info_dataset[0])
	else:
		emit_signal("show_book_info", info_dataset[book_id])
	
	
