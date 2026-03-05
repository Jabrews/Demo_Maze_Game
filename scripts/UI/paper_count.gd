extends Control 

@onready var curr_papers_label : Label = $Label


func _ready() -> void:
	GlLightingManager.connect('paper_collected', _handle_paper_collected)


func _handle_paper_collected () :
	curr_papers_label.text = str(GlLightingManager.totalPapersCollected)
