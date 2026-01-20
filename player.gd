extends CharacterBody2D

@export var speed := 400
@export var mode := "bass"
@export var bass_color := Color.from_rgba8(0, 0, 180, 255)
@export var treble_color := Color.from_rgba8(180, 0, 0, 255)

@onready var shield_timer = $ShieldTimer
@onready var dash_timer = $DashTimer

var is_shielded := false
var is_dashing := false

signal mode_switched

func _ready() -> void:
	modulate = bass_color # Default color for bass mode

func get_input() -> void:
	var input_direction := Input.get_vector("left", "right", "up", "down")
	velocity = (input_direction * speed)

func switch_mode() -> void:
	if mode == "bass":
		mode = "treble"
		modulate_color(mode)
		mode_switched.emit() # This signal is emitted on mode switch
		return
	if mode == "treble":
		mode = "bass"
		modulate_color(mode)
		mode_switched.emit() # This signal is emitted on mode switch... again
		return

func modulate_color(current_mode) -> void:
	if current_mode == "bass":
		modulate = bass_color
		return
	if current_mode == "treble":
		modulate = treble_color
		return

func shield() -> void:
	modulate = Color.AQUA
	is_shielded = true
	shield_timer.start()

func dash() -> void:
	is_dashing = true
	speed = 1500
	dash_timer.start()

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	if Input.is_action_just_pressed("switch_mode"):
		switch_mode()
	
	if mode == "bass":
		if Input.is_action_just_pressed("click") and is_shielded == false:
			shield()
		if Input.is_action_just_pressed("right_click") and is_dashing == false:
			dash()
			

func _on_shield_timer_timeout() -> void: # Callback for shield timer
	modulate_color(mode)
	is_shielded = false


func _on_dash_timer_timeout() -> void: # Callback for dash timer
	speed = 400
	is_dashing = false
