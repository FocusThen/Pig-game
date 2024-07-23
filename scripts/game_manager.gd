class_name GameManager extends Node

@export var healthGui: HealthGui
@export var player: Player
@onready var game_timer = $GameTimer

var score = 0
func addScore():
	print('addScore')
	score +=1
	healthGui.updateDiamond(score)

func _ready():
	game_timer.start()
	await game_timer.timeout
	var playerMaxHealth = player.get_node('HealthComponent').MaxHealth
	healthGui.maxHealth(playerMaxHealth)
	player.healthChanged.connect(healthGui.updateHealth)
	# make it more great
	healthGui.updateDiamond(0)
