extends Area2D

func _ready() -> void:
	self.look_at(get_global_mouse_position())
	
	$BigShotAnim.play("boom")

func _on_big_shot_anim_animation_finished(anim_name: StringName) -> void:
	queue_free()
