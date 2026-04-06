extends Area2D

func _ready() -> void:
	self.look_at(get_global_mouse_position())
	$AnimationPlayer.play("boom")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
