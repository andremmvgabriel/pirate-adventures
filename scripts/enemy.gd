extends RigidBody2D

class_name Enemy

# Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var knock = false
var knock_force = 100
var knock_direction = 1

func _physics_process(delta):
	if knock:
		var knock_impulse = Vector2(knock_force * knock_direction, -knock_force)
		apply_central_impulse(knock_impulse)
		knock = false

func _integrate_forces(state):
	# Block rotation
	rotation_degrees = 0
	
func hit(direction):
	print("Enemy taking damage")
	knock_direction = direction
	knock = true
