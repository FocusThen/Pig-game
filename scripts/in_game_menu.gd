extends Control
@onready var animation_player = $AnimationPlayer


func resume():
	animation_player.play_backwards("open_menu")	
	get_tree().paused = false

func pause():
	animation_player.play("open_menu")	
	get_tree().paused = true

func esc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()


func _on_btn_reset_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_btn_open_map_pressed():
	pass # Replace with function body.
func _on_btn_settings_pressed():
	pass # Replace with function body.

func _on_btn_quit_pressed():
	get_tree().quit()

func _ready():
	animation_player.play("RESET")

func _process(_delta):
	esc()
