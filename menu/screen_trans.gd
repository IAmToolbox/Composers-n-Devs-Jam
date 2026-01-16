extends CanvasLayer

func load_in(path : String): ##must be a string that contains a resource path 
	#var _scene = load(path).instantiate()
	
	$AnimationPlayer.play("load_in")
	await $AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(path)
	
	load_out()
	
func load_out():
	$AnimationPlayer.play("load_out")
	await $AnimationPlayer.animation_finished
