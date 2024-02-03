class_name WeaponComponent
extends Node 

@export var AnimatedSprite: AnimatedSprite2D
@export var BulletScene: PackedScene
@export var attack_interval_seconds: float

var time_since_last_attack_seconds: float = 0

var actor: CharacterBody2D
var bullet_group_name: String

func _ready():
	actor = find_group_node_in_parents()
	bullet_group_name = get_group_name_from_node(actor)

func _process(delta: float) -> void:
	time_since_last_attack_seconds += delta
	process_shooting()

func process_shooting() -> void:
	if Input.is_action_pressed("single_shoot") and time_since_last_attack_seconds >= attack_interval_seconds:
		attack()
		AnimatedSprite.play("attack")
		time_since_last_attack_seconds = 0

func attack() -> void:
	var bullet: Area2D = BulletScene.instantiate()
	bullet.set_meta("created_by", bullet_group_name)
	bullet.position = actor.position
	get_tree().root.add_child(bullet)

func find_group_node_in_parents(start_node: Node = self) -> Node:
	var current_node = start_node
	while current_node:
		if current_node.is_in_group("Player"):
			return current_node
		elif current_node.is_in_group("Enemy"):
			return current_node
		current_node = current_node.get_parent()
	return null

func get_group_name_from_node(node: Node) -> String:
	if node:
		if node.is_in_group("Player"):
			return "Player"
		elif node.is_in_group("Enemy"):
			return "Enemy"
	return ""
