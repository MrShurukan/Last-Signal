extends Camera2D

@export var camera_speed = 300

func _process(delta):
	var direction = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	var speed = camera_speed
	if Input.is_action_pressed("camera_accelerate"):
		speed *= 2
	position += direction * (speed * delta)
