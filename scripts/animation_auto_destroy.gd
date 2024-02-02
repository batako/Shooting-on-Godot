extends AnimatedSprite2D

func _ready():
	connect("animation_finished", _on_Animation_finished.bind())

func _on_Animation_finished():
	queue_free()
