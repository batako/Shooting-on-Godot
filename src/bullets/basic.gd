# 直進だけする弾

extends "res://src/bullets/base.gd"

# 弾の移動処理
func _move_bullet(delta):
	var velocity: Vector2 = Vector2(0, -speed)
	position += velocity * delta