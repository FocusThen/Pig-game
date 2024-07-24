class_name Diamond extends Area2D
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	Events.emit_signal("diamond_counter", 1)
	animation_player.play("pickup")
