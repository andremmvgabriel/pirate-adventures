extends RigidBody2D

class_name Enemy

# Serializable Variables
@export var health = 100
@export var decomposition_time = 60

# Variables
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Components
@onready var animator = $AnimatedSprite2D
#@onready var collider = $CollisionShape2D

var knock = false
var knock_force = 100
var knock_direction = 1

# Private functions
func _physics_process(delta):
	if animator.animation == "dead":
		await get_tree().create_timer(decomposition_time).timeout
		queue_free()
		return
	
	if knock:
		if health <= 0:
			animator.play("dead")
		else:
			animator.play("hit")
		var knock_impulse = Vector2(knock_force * knock_direction, -knock_force)
		apply_central_impulse(knock_impulse)
		knock = false
		return
	
	if animator.animation == "hit" and animator.is_playing():
		return
		
	animator.play("idle")

func _integrate_forces(state):
	# Block rotation
	rotation_degrees = 0

func _is_dead():
	return animator.animation == "dead"

# Public functions
func hit(damage, direction):
	if health <= 0: return
	health -= damage
	knock_direction = direction
	knock = true
