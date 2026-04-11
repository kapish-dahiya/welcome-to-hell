extends Node2D

var velocity = 70
var fire_dmg := 5
@onready var hit_area = $HitArea2d

func _ready() -> void:
	hit_area.dmg = fire_dmg

func _process(delta: float) -> void:
	$AnimationPlayer.play("fire")
	position.y += velocity*delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Walls":
		queue_free()
