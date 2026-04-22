extends Node2D
@export var small_shot_dmg: int= 5
@onready var hit_area: Area2D  = $HitArea2d
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	hit_area.dmg = small_shot_dmg
	self.look_at(get_global_mouse_position())
	anim_player.play("boom")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
