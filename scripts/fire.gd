extends Node2D

var speed := 70
var fire_dmg := 5
@onready var hit_area: Area2D = $HitArea2d
@onready var anim_player: AnimationPlayer = $AnimationPlayer
func _ready() -> void:
	hit_area.dmg = fire_dmg

func _process(delta: float) -> void:
	anim_player.play("fire")
	position.y += speed*delta

func _on_hit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("walls"):
		queue_free()

func _on_hit_area_2d_area_entered(_area: Area2D) -> void:
	queue_free()
