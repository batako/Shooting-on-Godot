class_name AttackComponent
extends Node

@export var WeaponRootNode: Node2D
@export var WeaponScenes: Array[PackedScene]
@export var default_weapon_scene_index: int = 0

@export var BulletScenes: Array[PackedScene]
@export var default_bullet_scene_index: int = 0

var actor: CharacterBody2D
var weapon_scene_index: int
var bullet_scene_index: int

var attack_interval_seconds: float = 0.2
var time_since_last_attack_seconds: float = 0

func _ready():
	actor = get_parent()
	weapon_scene_index = default_weapon_scene_index
	bullet_scene_index = default_bullet_scene_index
	set_weapon()

func _process(delta: float) -> void:
	time_since_last_attack_seconds += delta
	#process_shooting()

func process_shooting() -> void:
	if Input.is_action_pressed("single_shoot") and time_since_last_attack_seconds >= attack_interval_seconds:
		single_shoot_bullet()
		time_since_last_attack_seconds = 0

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

func set_weapon() -> void:
	var weapon: Node2D = WeaponScenes[weapon_scene_index].instantiate()
	WeaponRootNode.add_child(weapon)
