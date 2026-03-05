extends StaticBody3D

@export var vent_downward = false	
@export var vent_floor = 0

# notice : vent entering logic occurs on players ray cast

# components
@onready var hoverable_mesh := $hoverable_mesh
var down_arrow_bouncing_sprite_scene : PackedScene = preload("res://scenes/hover_bouncing_sprites/arrow_down_sprite.tscn")


func _ready() -> void:
	# setting proper bouncing sprite
	if vent_downward :
		hoverable_mesh.bouncing_sprite_scene  = down_arrow_bouncing_sprite_scene
		
