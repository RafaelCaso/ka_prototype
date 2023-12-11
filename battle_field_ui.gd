extends Control


func _ready() -> void:
	SignalBus.connect("unit_display", self, "display_unit_selected");
	SignalBus.connect("roll_die", self, "display_roll_result");
	
func display_unit_selected(unit):
	$ColorRect/UnitDisplay.text = unit;

func display_roll_result(result):
	$ColorRect2/RollDisplay.text = String(result);
