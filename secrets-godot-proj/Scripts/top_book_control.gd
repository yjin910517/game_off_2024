extends Control


signal passport_box_found(info_text)
signal show_book_info(info_text)

@onready var audio = $Audio

var info_dataset = [
	"???", # use zero index to store special info text for secrete pox
	"<Fragments of the Soul>\nElysia loved this book. She’d read a poem out loud to me sometimes, her voice soft, almost like she was letting me in on a secret.",
	"<The Lost Cultures of Serelva>\nShe used to say Serelva felt like a part of her, even though she’d only been there a few times.",
	"<Whispers of the Endless Sky>\nA poetic exploration of the cosmos and humanity’s eternal fascination with the stars.",
	null,
	"<The Traveler’s Journal: Tales from the Edge of the World>\nA vibrant anthology of travel stories from remote corners of the globe.",
	"<The Key to Every Door>\nA book of riddles and puzzles, of course. Elysia loved how it made her think, but what she loved more was solving them together with me.",
	"<Wonders Beneath the Waves>\nThis is my book. She read it so we could talk about my work, and I loved how excited she got about things I thought were just…normal.",
]

const secret_box_id = 4


func _ready():
	var book_nodes = get_children()
	for book in book_nodes:
		if book.name == "Audio":
			pass
		else:
			book.connect("book_clicked", Callable(self, "_on_book_clicked"))


func _on_book_clicked(book_name):
	var book_id = book_name.substr(4).to_int()
	if book_id == secret_box_id:
		emit_signal("passport_box_found", info_dataset[0])
	else:
		emit_signal("show_book_info", info_dataset[book_id])
		audio.play()
	
	
