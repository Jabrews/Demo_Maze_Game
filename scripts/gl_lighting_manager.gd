extends Node

## signals
signal paper_collected

var totalPapersCollected : int = 0

func _ready() -> void:
	connect('paper_collected', _handle_paper_collected)	
	
	
func _handle_paper_collected() :
	totalPapersCollected += 1
	
