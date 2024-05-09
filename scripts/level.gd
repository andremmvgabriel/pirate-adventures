extends Node2D

@onready var player = $Player
@onready var death_zone = $DeathZone
@onready var respawn_point = $RespawnPoint
@onready var shooters = $Shooters

@onready var shooter_prefabs = {
	Shooter.ShooterType.TotemHead1 : preload("res://prefabs/child_prefabs/totem_head_1_remainings.tscn"),
	Shooter.ShooterType.TotemHead2 : preload("res://prefabs/child_prefabs/totem_head_2_remainings.tscn"),
	Shooter.ShooterType.TotemHead3 : preload("res://prefabs/child_prefabs/totem_head_3_remainings.tscn")
}

func _ready():
	death_zone.connect("body_entered", _on_dead_zone_body_entered)
	
	for shooter in shooters.get_children():
		shooter.connect("shooter_destroyed", _on_shooter_destroyed)

func _process(delta):
	death_zone.global_position.x = player.global_position.x

func _on_dead_zone_body_entered(body):
	if body is Player:
		player.global_position = respawn_point.global_position

func _on_shooter_destroyed(type, position):
	var instance = shooter_prefabs[type].instantiate()
	instance.global_position = position
	add_child(instance)
	instance.explode()
