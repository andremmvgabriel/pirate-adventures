extends Node2D

@onready var player = $Player
@onready var death_zone = $DeathZone

func _ready():
	death_zone.connect("body_entered", _on_dead_zone_body_entered)

func _process(delta):
	death_zone.global_position.x = player.global_position.x

func _on_dead_zone_body_entered(body):
	print("wow")
