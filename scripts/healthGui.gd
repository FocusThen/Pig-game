class_name HealthGui extends Panel

@onready var h_box_container = $HBoxContainer
@onready var enums = $"../../Enums"
@onready var diamond_gui = $diamondGui
const HEART_GUI = preload("res://gui/heart_gui.tscn")



func maxHealth(health:int):
	for i in range(health):
		var heartInstrance = HEART_GUI.instantiate()
		h_box_container.add_child(heartInstrance)

func updateHealth(_currentHealth):
	var hearts = h_box_container.get_children()
	if(enums.DmgOrHeal.Dmg):
		hearts[hearts.size()-1].hitHeart()
	else:
		var heartInstrance = HEART_GUI.instantiate()
		h_box_container.add_child(heartInstrance)

func updateDiamond(score:int):
	diamond_gui.get_node("counter").text = str(score)
