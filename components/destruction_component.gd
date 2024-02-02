class_name DestructionComponent
extends Node

@export var sprite: Sprite2D
@export var max_frame: int
@export var frames_per_second: float

var actor: CharacterBody2D

var pattime: float = 0
var is_animating: bool = false

func _ready():
	actor = get_parent()
	validate()

func _process(delta: float):
	animation(delta)

func validate():
	var script_path = get_script().resource_path
	var actor_script_path = actor.get_script().resource_path
	assert(sprite, str(script_path) + ": sprite を設定してください。")
	assert(actor.current_hp, str(actor_script_path) + ": current_hp を設定してください。")
	assert(frames_per_second, str(script_path) + ": frames_per_second を設定してください。")

func animation(delta: float):
	if is_animating:
		pattime += delta
		sprite.frame = int(pattime * frames_per_second)
		if sprite.frame >= max_frame:
			actor.queue_free()

func start_animation():
	is_animating = true
	pattime = 0.0

func destroy():
	start_animation()
