extends Panel

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer

func _ready():
	animated_sprite.play("idle")

func hitHeart():
	animated_sprite.play("hit")
	timer.start()
	await timer.timeout
	queue_free()
