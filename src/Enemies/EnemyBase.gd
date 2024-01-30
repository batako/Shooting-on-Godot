extends Area2D

# 敵の名前
@export var enemy_name: String
# 敵の最大HP
@export var max_hp: int
# 現在のHP
var current_hp: int
var script_path = get_script().resource_path

func _ready():
	assert(enemy_name, str(script_path) + " の enemy_name が定義されていません。")
	assert(max_hp > 0, str(script_path) + " の max_hp を 0 より大きい値を設定してください。")
	
	current_hp = max_hp

# 衝突処理
func _on_area_entered(area):
	# 弾がヒットした場合はHPを減らす
	if area.is_in_group("Bullet"):
		var damage: int = area.get_damage()
		_take_damage(damage)

# ダメージ処理
func _take_damage(damage: int):
	current_hp -= damage
	print("HP: " + str(current_hp) + "/" + str(max_hp) + " (-" + str(damage) + ")")
	
	if current_hp <= 0:
		_die()

# 敵を消滅させる
func _die():
	print(enemy_name + " を倒しました。")
	queue_free()
