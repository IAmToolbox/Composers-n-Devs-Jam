extends CharacterBody2D

@export var speed := 400
@export var mode := "bass"
@export var bass_color := Color.from_rgba8(0, 0, 180, 255)
@export var treble_color := Color.from_rgba8(180, 0, 0, 255)

@onready var shield_timer := $ShieldTimer
@onready var dash_timer := $DashTimer
@onready var bullet_scene := preload("res://components/player_bullet.tscn")

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

func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.bullet_direction = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)

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
	if mode == "treble":
		if Input.is_action_just_pressed("click"):
			shoot()

func _on_shield_timer_timeout() -> void: # Callback for shield timer
	modulate_color(mode)
	is_shielded = false


func _on_dash_timer_timeout() -> void: # Callback for dash timer
	speed = 400
	is_dashing = false


func _on_hitbox_area_entered(area: Area2D) -> void:
	var entity_class = area.get_parent().get_script().get_global_name()
	
	if entity_class == "TrebleEnemy" || entity_class == "BassEnemy":
		if is_shielded:
			if is_dashing:
				area.get_parent().queue_free() #change later to trigger proper death anim and/or when enemies have actual health
				print('killed ' + entity_class)
			else:
				print('blocked contact with ' + entity_class)
		else:
			print('got hurt by ' + entity_class)
