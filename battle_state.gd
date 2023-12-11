extends Node


var battle_score : int = 0;
var player_score : int = 0;
var enemy_score : int = 0;
var active_units : Array = [];
var points_timer : Timer;
var battle_line_position : int;

func _ready():
	points_timer = Timer.new();
	add_child(points_timer)
	points_timer.connect("timeout", self, "_on_Points_Timer_timeout")
	points_timer.autostart = true;
	points_timer.start(2)
	SignalBus.connect("battle_line_position", self, "update_battle_line_position")


	

func _on_Points_Timer_timeout():
	battle_score = 0;
	player_score = 0;
	enemy_score = 0;
	for unit in active_units:
		if unit.is_in_group("player"):
			if unit.global_position.y < battle_line_position:
				player_score += 1;
		elif unit.is_in_group("enemy"):
			if unit.global_position.y > battle_line_position:
				enemy_score += 1;
	battle_score = player_score - enemy_score;
	SignalBus.emit_signal("update_battle_score", battle_score);

func append_active_unit(unit : KinematicBody2D):
	active_units.append(unit);

func remove_active_unit(unit):
	if unit in active_units:
		active_units.remove(unit);

func update_battle_line_position(line_position):
	battle_line_position = line_position;
