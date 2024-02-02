class_name AttackComponent
extends Node

var actor: CharacterBody2D

func _ready():
	actor = get_parent()

func _process(_delta: float) -> void:
	process_shooting()

func process_shooting() -> void:
	if Input.is_action_just_pressed("single_shoot"):
		single_shoot_bullet()

func single_shoot_bullet() -> void:
	# 弾のプレハブをロード
	var bullet: Area2D = preload("res://src/bullets/basic.tscn").instantiate()
	# 作成者のメタ情報に登録
	bullet.set_meta("created_by", get_actor_group_name())
	# 弾の位置をプレイヤーの位置に設定
	bullet.position = actor.position
	# 弾をシーンに追加
	get_tree().root.add_child(bullet)

func get_actor_group_name() -> String:
	if actor.is_in_group("Player"):
		return "Player"
	elif actor.is_in_group("Enemy"):
		return "Enemy"
	return ""
