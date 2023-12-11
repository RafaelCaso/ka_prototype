extends KinematicBody2D


var move_to = Vector2();
var move_speed = 6000;
var selected := false;
var moving := false;

func _ready() -> void:
	BattleState.append_active_unit(self)

func _physics_process(delta: float) -> void:
	if moving:
		var direction = (move_to - global_position).normalized();
		var velocity = direction * move_speed * delta;
		move_and_slide(velocity);
		if move_to == global_position:
			moving = false;
