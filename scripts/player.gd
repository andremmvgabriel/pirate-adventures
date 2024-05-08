extends CharacterBody2D

class_name Player

# Serializable Variables
@export var speed = 200
@export var jump_force = 300

# Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Components
@onready var animator = $AnimatedSprite2D
@onready var sword = $Sword
@onready var sword_collision = $Sword/CollisionShape2D

@onready var sword_collision_pos = sword_collision.position.x

# Private functions
func _ready():
	sword.connect("body_entered", _on_sword_body_entered)
	sword_collision.disabled = true

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
	
	# Sword direction handling
	if (x_direction):
		sword_collision.position.x = sword_collision_pos * x_direction
	
	move_and_slide()

func _update_animations(direction):
	if direction:
		animator.flip_h = (direction == -1)
	
	for attack_type in ["15_attack_1", "16_attack_2", "17_attack_3"]:
		if animator.animation == attack_type and animator.is_playing():
			return
	
	sword_collision.disabled = true
	var attack = Input.is_action_just_pressed("attack")
	
	if is_on_floor():
		if direction:
			animator.play("02_run")
		else:
			animator.play("01_idle")
		
		if attack:
			_attack()
	else:
		if velocity.y < 0:
			animator.play("03_jump")
		else:
			animator.play("04_fall")
		
		if attack:
			_attack()

func _attack():
	animator.play("15_attack_1")
	sword_collision.disabled = false

# Callbacks
func _on_sword_body_entered(body):
	if body is Enemy:
		var hit_dir = int(animator.flip_h == false) * 2 - 1
		body.hit(25, hit_dir)
	
	if body is Shooter:
		body.hit(25)
	
# Public functions
