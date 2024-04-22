extends Node2D

@export var grid_size: int = 128
@onready var ghost_tile = %GhostTile


# Called when the node enters the scene tree for the first time.
func _ready():
	var base_building = preload("res://buildings/base.tscn")
	var power_plant = preload("res://buildings/power_plant.tscn")
	place_building(base_building, 1, 2)
	place_building(power_plant, 2, 1, true)
	place_building(base_building, 3, 2)
	
var ghost_rotated = false
func _process(delta):
	if Input.is_action_just_pressed("rotate_building"):
		ghost_rotated = !ghost_rotated
	
	var mouse_position: Vector2 = get_global_mouse_position()
	# Clamp 'em
	mouse_position.x = int(mouse_position.x / grid_size) * grid_size
	mouse_position.y = int(mouse_position.y / grid_size) * grid_size
	
	if ghost_rotated:
		mouse_position.x += grid_size
		ghost_tile.rotation_degrees = 90
	else:
		ghost_tile.rotation_degrees = 0
	
	ghost_tile.position = mouse_position
	print(mouse_position)
	print(int(mouse_position.x / grid_size))

func _draw():
	# Debug grid
	for x in 10:
		draw_line(Vector2(x * grid_size, 0), Vector2(x * grid_size, 1000), Color(1, 1, 1))
		
	for y in 10:
		draw_line(Vector2(0, y * grid_size), Vector2(2000, y * grid_size), Color(1, 1, 1))
		
	print("_draw called")

func place_building(building_scene: PackedScene, grid_x: int, grid_y: int, rotated: bool = false):
	var building: Building = building_scene.instantiate()
	add_child(building)
	if rotated:
		building.rotation_degrees = 90
		grid_x += 1
	
	building.global_position.x = (grid_x * grid_size)
	building.global_position.y = (grid_y * grid_size)
	
