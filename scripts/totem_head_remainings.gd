extends Node2D

# Serializable Variables
@export var decomposition_time = 5

# Components
@onready var topper: RigidBody2D = $Topper
@onready var middle: RigidBody2D = $Middle
@onready var bottom: RigidBody2D = $Bottom

@onready var RNG = RandomNumberGenerator.new()

func _ready():
	var timer = Timer.new()
	timer.wait_time = decomposition_time
	timer.autostart = true
	add_child(timer)
	await timer.timeout
	queue_free()

func _project_part(part: RigidBody2D):
	var impulse = Vector2(
		RNG.randf_range(-200, 200),
		RNG.randf_range(-200, -100)
	)
	part.apply_central_impulse(impulse)
	
	var torque = RNG.randf_range(-100, 100) * 1000
	part.apply_torque(torque)

func explode():
	_project_part(topper)
	_project_part(middle)
	_project_part(bottom)
