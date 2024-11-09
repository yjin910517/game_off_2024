extends Control


signal passport_acquired()

var passport_found = false


func _ready():
	var book_nodes = get_children()
	for book in book_nodes:
		book.connect("book_clicked", Callable(self, "_on_book_clicked"))


func _on_book_clicked(book_name):
	var book_id = book_name.substr(4).to_int()
	print("clicked ", book_name)
