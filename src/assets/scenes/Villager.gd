extends KinematicBody2D


var speed = 200
var velocity = Vector2.ZERO
var target_pos = null

onready var animationVillager = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var move_vector = Vector2.ZERO
	if Input.is_action_pressed("mouse_rb"):
		target_pos = get_global_mouse_position()
	
	if target_pos:
		move_vector = target_pos - global_position
		velocity = move_vector.normalized() * speed
		animationTree.set("parameters/Idle/blend_position", move_vector)
		animationTree.set("parameters/Run/blend_position", move_vector)
		animationState.travel("Run")
		velocity = move_and_collide(velocity * delta)
		if global_position.distance_to(target_pos) < 5:
			target_pos = null
	else:
		animationState.travel("Idle")
