extends Area2D

var velocity = 70

func _process(delta: float) -> void:
	$AnimationPlayer.play("fire")
	position.y += velocity*delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Walls":
		queue_free()
