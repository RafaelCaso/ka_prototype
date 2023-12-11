extends Node


signal cycle_selection(selection)

#display unit type in BattleFieldUI
signal unit_display(unit)

signal battle_line_position(position)

signal roll_die(result)

signal player_advancing_line

signal enemy_advancing_line

signal update_battle_score(battle_score)

# generate a random number between 1 and 100
var random_gen = RandomNumberGenerator.new();
func roll_d100() -> int:
	# randomize the seed
	random_gen.randomize();
	var result = random_gen.randi_range(1,100);
	emit_signal("roll_die", result);
	return result
