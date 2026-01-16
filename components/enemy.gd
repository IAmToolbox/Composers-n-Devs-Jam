@abstract class_name Enemy extends CharacterBody2D
## Abstract class for enemies to inherit from

@export var speed : float = 1
@export var acceleration : float = 0.8

## This function is called when the enemy needs to move towards the player
func _move_towards_player() -> void:
	pass

## This function is called when the enemy needs to move towards an arbitrary target
func _move_towards_target() -> void:
	pass

## This function is called when the enemy fires a projectile
func _fire_projectile() -> void:
	pass
