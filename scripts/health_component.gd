class_name HealthComponent extends Node2D

@export var MaxHealth = 3
var currentHealth:int


func _ready():
	currentHealth = MaxHealth

func damage(attack):
	currentHealth += attack

func getCurrentHealth():
	return currentHealth
