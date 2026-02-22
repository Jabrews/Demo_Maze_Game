extends StaticBody3D 

@onready var table_light : OmniLight3D = $TableLight


func _ready() -> void:
	GlLightingManager.connect("paper_collected", _handle_paper_collected)


func _handle_paper_collected() :
	# get total papers
	var totalPapersCollected = GlLightingManager.totalPapersCollected
	# switch case for lighting values
	match totalPapersCollected :
		1 : 
			table_light.omni_range= 10.000
		2 : 
			table_light.omni_range =  9.000
		3 : 
			table_light.omni_range = 8.000
		4 : 
			table_light.omni_range= 7.200
		5 : 
			table_light.omni_range= 6.500
	
