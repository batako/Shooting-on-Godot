class_name HealthComponent
extends Node

var actor: CharacterBody2D

var is_destroying: bool = false

func _ready():
	actor = get_parent()
	actor.current_hp = actor.max_hp
	validate()

func _physics_process(delta):
	var collision = actor.move_and_collide(actor.velocity * delta)
	if collision:
		var collider = collision.get_collider()
		# 機体の衝突
		if collider.is_in_group("Player") or collider.is_in_group("Enemy"):
			apply_damage(actor.max_hp * 0.1)

func validate():
	var actor_script_path = actor.get_script().resource_path
	assert(actor.max_hp > 0, str(actor_script_path) + ": max_hp を 0 より大きい値を設定してください。")

func apply_damage(damage: float) -> void:
	if is_destroying:
		return

	actor.current_hp -= damage
	print(get_parent().name + " HP: " + str(actor.current_hp) + "/" + str(actor.max_hp) + " (-" + str(damage) + ")")
	
	if actor.current_hp <= 0:
		is_destroying = true
		var destruction_component = find_destruction_component()
		if destruction_component:
			destruction_component.destroy()
		else:
			actor.queue_free()

func find_destruction_component() -> DestructionComponent:
	for child in actor.get_children():
		if child is DestructionComponent:
			return child
	return null
