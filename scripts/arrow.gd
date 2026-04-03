extends RigidBody2D

var direction = Vector2(150,-150).normalized()
var arrow_speed = 200

func _ready() -> void:
	linear_velocity = arrow_speed*direction

func _on_timer_timeout() -> void:
	queue_free()

#func _on_body_entered(body: Node) -> void:
