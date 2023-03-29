extends CharacterBody2D


const GRAVITY = 40
var speed = 100
@export var direction = -1
@export var detects_cliffs = true
@export var move = true
var movement = true

func _ready():
	$AnimatedSprite2D.play("walk")
	
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	$FloorDetector.position.x = $CollisionShape2D.shape.get_size().x * direction + 5
	$FloorDetector.enabled = detects_cliffs


func _physics_process(delta):
	if move == true:
		if is_on_wall() or not $FloorDetector.is_colliding() and detects_cliffs and is_on_floor():
			direction *= -1
			$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
			if direction == 1:
				$FloorDetector.position.x = $CollisionShape2D.shape.get_size().x * direction -10
			elif direction == -1:
				$FloorDetector.position.x = $CollisionShape2D.shape.get_size().x * direction + 10
		
		velocity.y += GRAVITY
		velocity.x = speed * direction
		move_and_slide()
		
		
		
func _on_Area2D_body_entered(body):
	$AnimatedSprite2D.stop()
	speed = 0
	$AnimatedSprite2D.play("die")
	set_collision_layer_value(2,false)
	set_collision_mask_value(0,false)
	$DeathSound.play()
	
	body.bounce()
	
	await get_tree().create_timer(.5).timeout
	queue_free()
	
	
	
func stop_moving():
	move = false
	
func moving():
	move = true
