class_name Diamond extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(_body):
	game_manager.addScore()
	queue_free()
