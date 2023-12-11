extends Area2D

var direction : Vector2 = Vector2(0,-1);
var speed = BattleState.battle_score;
var line_advancing := false;

func _ready() -> void:
	SignalBus.connect("update_battle_score", self, "update_line_position")

func _process(delta: float) -> void:
	# Make battle_line position globally available for reference
	emit_position()

func update_line_position(battle_score):
	if battle_score > 0:
		winning()
	elif battle_score < 0:
		losing()

func winning():
	var target_y = global_position.y - 10;
	$Tween.interpolate_property(
		self,
		"global_position:y",
		global_position.y,
		target_y,
		1,
		Tween.TRANS_LINEAR
	) 
	$Tween.start();

	

func losing():
	var target_y = global_position.y + 10;
	$Tween.interpolate_property(
		self,
		"global_position:y",
		global_position.y,
		target_y,
		1,
		Tween.TRANS_LINEAR
	) 
	$Tween.start();

func emit_position():
	SignalBus.emit_signal("battle_line_position", global_position.y);
