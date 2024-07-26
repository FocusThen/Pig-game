extends Control
@onready var animation_player = $AnimationPlayer
@onready var bg_music = $BGMusic
@onready var sfx = $SFX
@onready var music_slider = $SettingsMenu/MarginContainer/VBoxContainer/SettingsMusic/MusicSlider
@onready var sfx_slider = $SettingsMenu/MarginContainer/VBoxContainer/SettingsSFX/SFXSlider
@onready var fs_checkbox = $SettingsMenu/MarginContainer/VBoxContainer/SettingsFS/FSCheckbox


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

func _on_btn_quit_pressed():
	get_tree().quit()

func _ready():
	animation_player.play("RESET")

func _process(_delta):
	esc()


func _on_btn_back_pressed():
	animation_player.play_backwards("settings_menu")
	await animation_player.animation_finished
	animation_player.play("open_menu")

func _on_btn_settings_pressed():
	animation_player.play_backwards("open_menu")
	await animation_player.animation_finished
	animation_player.play("settings_menu")
	
func _change_volume(volume, bus):
	if volume == music_slider.min_value:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(bus),false)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus),volume)
	


func _on_music_slider_value_changed(value):
	bg_music.play()	
	_change_volume(value, "Music")


func _on_sfx_slider_value_changed(value):
	sfx.play()	
	_change_volume(value, "SFX")


func _on_fs_checkbox_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
