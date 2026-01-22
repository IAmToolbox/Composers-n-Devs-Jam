extends Node2D

@export var enemy_scene: Array[PackedScene]

@onready var player = $player
@onready var label = $Label
@onready var bass_music = $BassMusic
@onready var treble_music = $TrebleMusic

func _ready() -> void:
	var treble_bus_index = AudioServer.get_bus_index("TrebleMusic")
	AudioServer.set_bus_mute(treble_bus_index, true)

func _on_player_mode_switched() -> void:
	label.text = "Mode: " + player.mode
	
	# This spaghetti switches between the two music tracks playing
	var bass_bus_index = AudioServer.get_bus_index("BassMusic")
	var treble_bus_index = AudioServer.get_bus_index("TrebleMusic")
	if AudioServer.is_bus_mute(bass_bus_index):
		AudioServer.set_bus_mute(treble_bus_index, true)
		AudioServer.set_bus_mute(bass_bus_index, false)
	elif AudioServer.is_bus_mute(treble_bus_index):
		AudioServer.set_bus_mute(treble_bus_index, false)
		AudioServer.set_bus_mute(bass_bus_index, true)

func _on_enemy_spawn_timer_timeout() -> void: # TODO: Replace this function with something that allows the enemy to actually follow the player
	var enemy = enemy_scene[randi_range(0,1)].instantiate()
	var enemy_spawn_location := $EnemySpawn/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	
	var direction : float = enemy_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	
	#var velocity := Vector2(randf_range(150.0, 200.0), 0)
	#enemy.set_velocity(velocity.rotated(direction))
	
	add_child(enemy)
