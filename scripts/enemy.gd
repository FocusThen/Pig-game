extends CharacterBody2D

var speed = -100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var health_component = $HealthComponent
@onready var animation_tree = $AnimationTree
@onready var under_check = $UnderCheck
@onready var foward_check = $FowardCheck

var isAlive := true
var state_machine
var facing_right = false

@export var is_moveable := true

func _ready():
	state_machine = animation_tree.get('parameters/playback')

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if !under_check.is_colliding() && is_on_floor() && is_moveable:
		flip()
	if foward_check.is_colliding() && is_on_wall():
		flip()
		
	if isAlive:
		move_and_slide()
		if is_moveable:
			velocity.x = speed


func _on_hit_box_component_area_entered(area):
	if area.name == "Weapon":
		var hurt = -1
		health_component.damage(hurt)
		
	if health_component.currentHealth == 0:
		isAlive = false
		state_machine.travel('dead')
		await animation_tree.animation_finished
		self.queue_free()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
	


