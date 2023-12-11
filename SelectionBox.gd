extends TextureRect

var is_selecting := false;
var start_position := Vector2();
var end_position := Vector2();
onready var area2d = $Area2D;
onready var collision_shape = $Area2D/CollisionShape2D;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lmb"):
		for body in BattleState.active_units:
			body.selected = false;
		is_selecting = true;
		start_position = get_global_mouse_position()
		area2d.monitoring = true;
	elif event.is_action_released("lmb"):
		is_selecting = false;
		end_position = get_global_mouse_position()
		update_selection_area()

func _process(delta: float) -> void:
	update_selection_area();

func update_selection_area():
	if is_selecting:
		collision_shape.disabled = false;
		var current_position = get_global_mouse_position();
		var selection_box_size = current_position - start_position;
		area2d.global_position = start_position;
		collision_shape.shape.extents = (selection_box_size / 2);
		collision_shape.global_position = current_position - collision_shape.shape.extents
		rect_size = selection_box_size
		set_global_position(start_position)

	else:
		collision_shape.disabled = true;
		rect_min_size = Vector2(0,0)
		rect_size = Vector2(0,0)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.selected = true;
