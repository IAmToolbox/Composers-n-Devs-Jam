extends Node2D

@export var enemy_scene: Array[PackedScene]

@onready var player = $player
@onready var label = $Label


func _on_player_mode_switched() -> void:
	label.text = "Mode: " + player.mode

func _on_enemy_spawn_timer_timeout() -> void: # TODO: Replace this function with something that allows the enemy to actually follow the player
	var enemy = enemy_scene[randi_range(0,1)].instantiate()
	var enemy_spawn_location := $EnemySpawn/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	
	var direction : float = enemy_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	var velocity := Vector2(randf_range(150.0, 200.0), 0)
	enemy.linear_velocity = velocity.rotated(direction)
	
	add_child(enemy)
