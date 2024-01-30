extends Area2D

# エディタから調整可能な速度変数
@export var speed: float = 700

func _process(delta: float) -> void:
	_process_player_movement(delta)
	_process_shooting()

func _process_player_movement(delta: float) -> void:
	var movement = _get_player_movement()
	_move_player(movement, delta)

func _get_player_movement() -> Vector2:
	var movement = Vector2()  # 移動ベクトルの初期化
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	return movement

func _move_player(movement: Vector2, delta: float) -> void:
	movement = movement.normalized() * speed
	var new_position = position + movement * delta
	# 画面外への移動を制限
	new_position.x = clamp(new_position.x, 0, get_viewport_rect().size.x)
	new_position.y = clamp(new_position.y, 0, get_viewport_rect().size.y)
	position = new_position

func _process_shooting() -> void:
	if Input.is_action_just_pressed("single_shoot"):
		_single_shoot_bullet()

func _single_shoot_bullet() -> void:
	# 弾のプレハブをロード
	var bullet: Area2D = preload("res://src/Bullets/BulletBasic.tscn").instantiate()
	# 弾の位置をプレイヤーの位置に設定
	bullet.position = self.position
	# 弾をシーンに追加
	get_parent().add_child(bullet)
