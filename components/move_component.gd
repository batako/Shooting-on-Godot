class_name MoveComponent
extends Node

var actor: CharacterBody2D

@export var move_speed: float = 500

func _ready():
	actor = get_parent()

func _process(_delta: float):
	actor.velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		actor.velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		actor.velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		actor.velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		actor.velocity.y -= 1

	actor.velocity = actor.velocity.normalized() * move_speed

	actor.move_and_slide()
	
	# 移動制限
	#restrict_to_screen()

# 画面外に出ないように位置を制限
func restrict_to_screen():
	var viewport_rect = actor.get_viewport_rect()
	actor.position.x = clamp(actor.position.x, 0, viewport_rect.size.x)
	actor.position.y = clamp(actor.position.y, 0, viewport_rect.size.y)
