extends Node2D

var big_shot_dmg := 10
@onready var hit_area = $HitArea2d

func _ready() -> void:
	hit_area.dmg = big_shot_dmg
	self.look_at(get_global_mouse_position())
	
	$BigShotAnim.play("boom")

func _on_big_shot_anim_animation_finished(_anim_name: StringName) -> void:
	queue_free()
