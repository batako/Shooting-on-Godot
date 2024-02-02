extends Area2D

# 弾の速度
@export var speed: float = 1000
# 弾のダメージ量
@export var damage: int = 1
# 画面外のマージン
const OFF_SCREEN_MARGIN: int = 10
# ファイルのパス取得
var script_path = get_script().resource_path

func _process(delta: float):
	_move_bullet(delta)
	_check_off_screen()

func _on_body_entered(body: Node):
	var created_by = str(get_meta("created_by"))
	
	# 衝突した対象が作成者ではないこと
	if !body.is_in_group(created_by):
		var health_component: HealthComponent = find_health_component(body)
		health_component.apply_damage(damage)
		queue_free()

# 弾の移動処理
func _move_bullet(_delta: float):
	assert(false, str(script_path) + " の _move_bullet を上書きしてください。")

# 画面外の場合は削除
func _check_off_screen():
	var screen_size: Vector2 = get_viewport_rect().size
	if position.y < -OFF_SCREEN_MARGIN or position.y > screen_size.y + OFF_SCREEN_MARGIN:
		queue_free()

# ダメージ量を取得
func get_damage() -> int:
	return damage

func find_health_component(body: Node) -> Node:
	for child in body.get_children():
		if child is HealthComponent:
			return child
	return null
