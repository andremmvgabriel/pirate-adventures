extends RigidBody2D

class_name Shooter

# Serializable Variables
@export var health = 100
@export var decomposition_time = 60
@export var is_top = true

# Components
@onready var animator = $AnimatedSprite2D
@onready var top_part = $Parts/Top
@onready var middle_part = $Parts/Middle
@onready var bottom_part = $Parts/Bottom

# Private functions
func _ready():
	if is_top:
		animator.play("idle_top")
	else:
		animator.play("idle")
	top_part.visible = false
	middle_part.visible = false
	bottom_part.visible = false

func _explode():
	top_part.visible = true
	middle_part.visible = true
	bottom_part.visible = true
	animator.visible = false

# Public functions
func hit(damage):
	if health <= 0: return
	health -= damage
	
	if is_top:
		animator.play("hit_top")
	else:
		animator.play("hit")
	
	if health <= 0:
		if is_top:
			animator.play("destroy_top")
		else:
			animator.play("destroy")
		_explode()
