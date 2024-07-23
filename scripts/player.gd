class_name Player extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var enums = $"../Enums"
@onready var animation_tree = $AnimationTree

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var health_component = $HealthComponent

signal healthChanged
var isAlive := true
var isAttacking := false

var state_machine

func _ready():
	state_machine = animation_tree.get('parameters/playback')

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		state_machine.travel("attack")
		isAttacking = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		state_machine.travel("jump")
		velocity.y = JUMP_VELOCITY
		
	
	var direction = Input.get_axis("move_left", "move_right")

	if isAlive:
		if not isAttacking:
			if direction > 0:
				animated_sprite.flip_h = false
			elif direction < 0:
				animated_sprite.flip_h = true
				
			if direction == 0:
				state_machine.travel("idle")
			elif direction != 0:
				state_machine.travel("run")
				
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				
		move_and_slide()

func _on_hit_box_component_area_entered(area):
	if area.has_method("damage"):
		state_machine.travel("hurt")
		health_component.currentHealth -=1
		healthChanged.emit(enums.DmgOrHeal.Dmg)
		
	if health_component.currentHealth == 0:
		state_machine.travel('dead')
		await animation_tree.animation_finished
		self.queue_free()


func _on_animation_tree_animation_finished(anim_name):
	if "attack" in anim_name:
		isAttacking = false
