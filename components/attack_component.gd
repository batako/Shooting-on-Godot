class_name AttackComponent
extends Node

@export var BulletScenes: Array[PackedScene]
@export var default_bullet_scene_index: int = 0

var actor: CharacterBody2D
var bullet_scene_index: int

func _ready():
	actor = get_parent()
	bullet_scene_index = default_bullet_scene_index

func _process(_delta: float) -> void:
	process_shooting()

func process_shooting() -> void:
	if Input.is_action_just_pressed("single_shoot"):
		single_shoot_bullet()

func single_shoot_bullet() -> void:
	var bullet: Area2D = BulletScenes[bullet_scene_index].instantiate()
	bullet.set_meta("created_by", get_actor_group_name())
	bullet.position = actor.position
	get_tree().root.add_child(bullet)

func get_actor_group_name() -> String:
	if actor.is_in_group("Player"):
		return "Player"
	elif actor.is_in_group("Enemy"):
		return "Enemy"
	return ""
