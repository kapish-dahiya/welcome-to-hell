extends StaticBody2D


func _process(_delta: float) -> void:
	$AnimationPlayer.play("cage")
	await get_tree().create_timer(5).timeout
	queue_free()
