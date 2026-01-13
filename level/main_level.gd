extends Node2D

@onready var player = $player
@onready var label = $Label


func _on_player_mode_switched() -> void:
	label.text = "Mode: " + player.mode
