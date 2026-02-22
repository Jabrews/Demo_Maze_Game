extends Node3D

@onready var block_light : OmniLight3D = $BlockLight


func _ready() -> void:
	GlLightingManager.connect("paper_collected", _handle_paper_collected)


func _handle_paper_collected() :
	# get total papers
	var totalPapersCollected = GlLightingManager.totalPapersCollected
	# switch case for lighting values
	match totalPapersCollected :
		1 : 
			block_light.omni_range = 6.000
			block_light.light_energy = 3.200
		2 : 
			block_light.omni_range = 5.000
			block_light.light_energy = 3.000
		3 : 
			block_light.omni_range = 4.200
			block_light.light_energy = 2.800
		4 : 
			block_light.omni_range = 3.900
			block_light.light_energy = 2.300
		5 : 
			block_light.omni_range = 3.800
			block_light.light_energy = 2.000
		6 :	
			block_light.omni_range = 2.900
			block_light.light_energy = 1.900
	
	
