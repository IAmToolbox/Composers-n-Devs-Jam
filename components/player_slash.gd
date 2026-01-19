extends Area2D

func _ready() -> void:
	look_at(get_global_mouse_position())

func _on_timer_timeout() -> void:
	queue_free()
