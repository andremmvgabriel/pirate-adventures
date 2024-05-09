extends RigidBody2D

class_name Shooter

enum ShooterType {
	TotemHead1,
	TotemHead2,
	TotemHead3
}

signal shooter_destroyed (type, position)

# Serializable Variables
@export var health = 100
@export var decomposition_time = 60
@export var is_top = true
@export var shooter_type = ShooterType.TotemHead1

# Components
@onready var animator = $AnimatedSprite2D

# Private functions
func _ready():
	if is_top:
		animator.play("idle_top")
	else:
		animator.play("idle")

func _destroy():
	if is_top:
		animator.play("destroy_top")
	else:
		animator.play("destroy")
	await animator.animation_finished
	shooter_destroyed.emit(shooter_type, global_position)
	queue_free()

# Public functions
func hit(damage):
	if health <= 0: return
	health -= damage
	
	if is_top:
		animator.play("hit_top")
	else:
		animator.play("hit")
	
	if health <= 0:
		_destroy()
