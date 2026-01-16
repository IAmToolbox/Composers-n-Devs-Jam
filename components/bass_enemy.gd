class_name BassEnemy extends Enemy

func _ready() -> void:
	speed = randf_range(1,3)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _move_towards_player() -> void:
	if get_node_or_null("/root/mainLevel/player") != null:
		look_at(get_node("/root/mainLevel/player").position)
		position.x = move_toward(position.x, get_node("/root/mainLevel/player").position.x, acceleration)
		position.y = move_toward(position.y, get_node("/root/mainLevel/player").position.y, acceleration)

func _process(delta) -> void:
	
	_move_towards_player()
	move_and_slide()
