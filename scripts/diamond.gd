class_name Diamond extends Area2D

func _on_body_entered(_body):
	Events.emit_signal("diamond_counter", 1)
	queue_free()
