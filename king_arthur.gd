extends KinematicBody2D

var velocity : Vector2
var speed = 5000;
var infantry := 2;
var cavalry := 1;
var selected := false;

func _physics_process(delta: float) -> void:
	var input_vector = Vector2();
	if Input.is_action_pressed("w"):
		if global_position.y > BattleState.battle_line_position:
			input_vector.y -= 1
	if Input.is_action_pressed("a"):
		input_vector.x -= 1
	if Input.is_action_pressed("s"):
		input_vector.y += 1
	if Input.is_action_pressed("d"):
		input_vector.x += 1
	input_vector = input_vector.normalized()
	velocity = input_vector * speed * delta
	
	velocity = move_and_slide(velocity)
