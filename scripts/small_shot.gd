extends Node2D
@export var small_shot_dmg = 5
@onready var hit_area = $HitArea2d
func _ready() -> void:
	hit_area.dmg = small_shot_dmg
	self.look_at(get_global_mouse_position())
	$AnimationPlayer.play("boom")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
