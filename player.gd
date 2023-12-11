extends Node2D

#******I think this is going to be boring. This is looking like total war but 2d and boring.
# Should make it so you have roster of heroes. They have the abiity to generate different units/abilities
# those abilities/unit/amount of units can be customized depending on hero's config 
# (wizard might be able to summon an infantry but only 1 or something
# Hero's can only move up to the limit (here it's half way up the screen)
# but their abilities/units can appear anywhere/within their sphere of influence
# maybe have a unit that emits another aoe that draws units towards it
# stnadard infantry can move anywhere within the hero's spere of influence
# spells can be cast within the sphere of influence but then move outside of it
# this will at least make the game unique/differ from total war

onready var king_arthur = $KingArthur

var infantry = preload("res://Infantry.tscn");
var cavalry = preload("res://Cavalry.tscn");

const UNITS = ["infantry", "cavalry", "artillery", "medic", "sniper", "flamethrower"]
var toggled_unit : String;
var spawn_point = Vector2(965,1000)



	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		toggled_unit = UNITS[0];
	if Input.is_action_just_pressed("2"):
		toggled_unit = UNITS[1];
	if Input.is_action_just_pressed("3"):
		toggled_unit = UNITS[2];
	if Input.is_action_just_pressed("4"):
		toggled_unit = UNITS[3];
	if Input.is_action_just_pressed("5"):
		toggled_unit = UNITS[4];
	if Input.is_action_just_pressed("6"):
		toggled_unit = UNITS[5];

	SignalBus.emit_signal("unit_display", toggled_unit)

	if toggled_unit and Input.is_action_just_pressed("r"):
		var unit_instance;
		if toggled_unit == "infantry" and $KingArthur.infantry > 0:
			unit_instance = infantry.instance();
			$KingArthur.infantry -= 1;
		if toggled_unit == "cavalry" and $KingArthur.cavalry > 0:
			unit_instance = cavalry.instance();
			$KingArthur.cavalry -= 1;
		
		if unit_instance:
			var target_position = get_global_mouse_position();
			unit_instance.global_position = spawn_point;
			spawn_unit(unit_instance);
	
	if Input.is_action_just_pressed("rmb"):
		var target_position = get_global_mouse_position();
		for unit in BattleState.active_units:
			if unit.selected:
				unit.moving = true;
				unit.move_to = target_position
	# Dice Roll currently has no application
	# may remove entirely. Think this game prototpye will be more of a cross
	# between 2d rts (moving the line with infantry)
	# and Vampire Survivor (stopping the hordes of bad guys with Heroes)
	# this will be an auto-shoot type mechanic that always hits
	if Input.is_action_just_pressed("r"):
		SignalBus.roll_d100();

func spawn_unit(unit : KinematicBody2D):
	# All units MUST HAVE METHOD CALLED move_to
	unit.move_to = spawn_point;
	add_child(unit);
	

