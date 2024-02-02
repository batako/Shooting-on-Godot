class_name DamageTextureComponent
extends Node

var actor: CharacterBody2D

@export var Sprite: Sprite2D

# ダメージに応じた画像
# 76-100%
@export var healthy_texture: Texture
# 51-75%
@export var minor_damage_texture: Texture
# 26-50%
@export var major_damage_texture: Texture
# 0-25%
@export var critical_damage_texture: Texture

func _ready():
	actor = get_parent()

	validate()
	update_texture()

func _process(_delta: float) -> void:
	update_texture()

func validate():
	var script_path: String = actor.get_script().resource_path
	
	assert(Sprite, str(script_path) + ": DamageTextureComponent の Sprite を設定してください。")
	assert(healthy_texture, str(script_path) + ": DamageTextureComponent の healthy_texture を設定してください。")

func update_texture():
	var hp_ratio = actor.current_hp / actor.max_hp

	if hp_ratio > 0.75:
		Sprite.texture = healthy_texture
	elif hp_ratio > 0.5:
		if minor_damage_texture is Texture:
			Sprite.texture = minor_damage_texture
	elif hp_ratio > 0.25:
		if major_damage_texture is Texture:
			Sprite.texture = major_damage_texture
	else:
		if critical_damage_texture is Texture:
			Sprite.texture = critical_damage_texture
