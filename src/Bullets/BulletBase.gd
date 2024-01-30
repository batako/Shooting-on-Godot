extends Area2D

# 弾の速度
@export var speed: float = 1000
# 弾のダメージ量
@export var damage: int = 1
# 画面外のマージン
const OFF_SCREEN_MARGIN: int = 10
# ファイルのパス取得
var script_path = get_script().resource_path

func _process(delta):
	_move_bullet(delta)
	_check_off_screen()

func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()

# 弾の移動処理
func _move_bullet(_delta):
	assert(false, str(script_path) + " の _move_bullet を上書きしてください。")

# 画面外の場合は削除
func _check_off_screen():
	var screen_size: Vector2 = get_viewport_rect().size
	if position.y < -OFF_SCREEN_MARGIN or position.y > screen_size.y + OFF_SCREEN_MARGIN:
		queue_free()

# ダメージ量を取得
func get_damage() -> int:
	return damage
