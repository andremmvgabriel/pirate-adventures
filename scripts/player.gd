extends CharacterBody2D

class_name Player

# Serializable Variables
@export var speed = 200
@export var jump_force = 300

# Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Components
@onready var animator = $AnimatedSprite2D

# Private functions
func _physics_process(delta):
	# Gravity handling
	if not is_on_floor():
		velocity.y += gravity * delta
		#velocity.y = clampf(velocity.y, -10000000, )
	
	# Jump handling
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	# Left & Right movement handling
	var x_direction = Input.get_axis("move_left", "move_right")
	_update_animations(x_direction)
	velocity.x = x_direction * speed
	
	move_and_slide()

func _update_animations(direction):
	if direction:
		animator.flip_h = (direction == -1)
	
	for attack_type in ["15_attack_1", "16_attack_2", "17_attack_3"]:
		if animator.animation == attack_type and animator.is_playing():
			return
			
	var attack = Input.is_action_just_pressed("attack")
	
	if is_on_floor():
		if direction:
			animator.play("02_run")
		else:
			animator.play("01_idle")
		
		if attack:
			animator.play("15_attack_1")
	else:
		if velocity.y < 0:
			animator.play("03_jump")
		else:
			animator.play("04_fall")
		
		if attack:
			animator.play("17_attack_3")

# Callbacks
	
# Public functions
