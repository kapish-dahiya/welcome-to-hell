extends CharacterBody2D

@onready var player = $/root/World/Player

const SPEED = 50;
var health = 5;

func _physics_process(_delta) -> void:
	velocity = (player.global_position - global_position).normalized() * SPEED

	move_and_slide();
	look_at(player.global_position)
	
