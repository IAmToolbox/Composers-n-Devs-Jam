extends Enemy

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

var total_DT = 0
func _process(delta) -> void:
	total_DT += delta
	
	$Sprite2D.position.x = (cos(5*total_DT)) * 20
	$Sprite2D.position.y = (sin(7*total_DT)) * 20
	$CollisionShape2D.position.x = (cos(5*total_DT)) * 20
	$CollisionShape2D.position.y = (sin(7*total_DT)) * 20
