class_name HealthGui extends Panel

@onready var h_box_container = $HBoxContainer
@onready var diamond_gui = $diamondGui
@export var player: Player
const HEART_GUI = preload("res://gui/heart_gui.tscn")

var diamonds = 0

func _ready():
	Events.connect("diamond_counter", updateDiamond)
	Events.connect("player_health", updateHealth)
	maxHealth(player.get_node('HealthComponent').MaxHealth)
	updateDiamond(diamonds)

func maxHealth(health:int):
	for i in range(health):
		var heartInstrance = HEART_GUI.instantiate()
		h_box_container.add_child(heartInstrance)

func updateHealth(new_health):
	var hearts = h_box_container.get_children()
	if(new_health < 0):
		hearts[hearts.size()-1].hitHeart()
	else:
		var heartInstrance = HEART_GUI.instantiate()
		h_box_container.add_child(heartInstrance)

func updateDiamond(score:int):
	diamonds += score
	diamond_gui.get_node("counter").text =  str(diamonds)
	
