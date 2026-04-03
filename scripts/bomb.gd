extends RigidBody2D
var bomb_speed = 700
var throw_direction = Vector2(150,-150).normalized()
func _ready() -> void:
	linear_velocity = bomb_speed*throw_direction
	await get_tree().create_timer(1).timeout
	freeze = true
	$BombSprite.set_visible(false)
	$Explosion.set_visible(true)
	$AnimationPlayer.play("explode")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
