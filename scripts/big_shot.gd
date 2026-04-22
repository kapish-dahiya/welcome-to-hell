extends Node2D

var big_shot_dmg := 10
@onready var hit_area: Area2D = $HitArea2d
@onready var big_shot_anim: AnimationPlayer = $BigShotAnim

func _ready() -> void:
	hit_area.dmg = big_shot_dmg
	self.look_at(get_global_mouse_position())
	
	big_shot_anim.play("boom")
func _on_big_shot_anim_animation_finished(_anim_name: StringName) -> void:
	queue_free()
