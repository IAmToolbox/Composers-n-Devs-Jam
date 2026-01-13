extends CharacterBody2D

@export var speed := 400
@export var mode := "bass"

signal mode_switched

func _ready() -> void:
	modulate = Color.from_rgba8(0, 0, 180, 255) # Default color for bass mode

func get_input() -> void:
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = (input_direction * speed)

func switch_mode() -> void:
	if mode == "bass":
		mode = "treble"
		modulate = Color.from_rgba8(180, 0, 0, 255)
		mode_switched.emit() # This signal is emitted on mode switch
		return
	if mode == "treble":
		mode = "bass"
		modulate = Color.from_rgba8(0, 0, 180, 255)
		mode_switched.emit() # This signal is emitted on mode switch... again
		return


func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("switch_mode"):
		switch_mode()
