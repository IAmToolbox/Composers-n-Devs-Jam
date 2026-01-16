extends Area2D

@export var speed := 700

var bullet_direction : Vector2

func _process(delta: float) -> void:
	position -= bullet_direction * speed * delta
