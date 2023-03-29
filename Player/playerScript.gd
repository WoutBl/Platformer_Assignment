extends CharacterBody2D

var is_dead = false
var score = 0
const JUMP_VELOCITY = -550.0
const MAX_SPEED = 500
const ACCEL = 300
const FRICTION = 700
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 981
@onready var anim = $AnimatedSprite2D
var move = true

func start():
	is_dead = false
	position.x = 20
	position.y = 100
	

func _physics_process(delta):
	if is_dead == false:
		if not is_on_floor():
				velocity.y += gravity * delta
		if move == true:
			
			# Handle Jump.
			if Input.is_action_just_pressed("Jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				if not is_on_floor(): 
					anim.play("jump")

			if Input.is_action_pressed("Right"):
				while(velocity.x < 0):
					velocity.x = move_toward(velocity.x, MAX_SPEED, ACCEL*delta*1.5)
				velocity.x = move_toward(velocity.x, MAX_SPEED, ACCEL*delta)
				if is_on_floor():
					anim.play("run")
					anim.flip_h = false
				else:
					anim.play("jump")
			elif Input.is_action_pressed("Left"):
				while(velocity.x > 0):
					velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCEL*delta*1.5)
				velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCEL*delta)
				if is_on_floor():
					anim.play("run")
					anim.flip_h = true
				else:
					anim.play("jump")
					
			else:
				velocity.x = move_toward(velocity.x, 0 , FRICTION * delta)
				anim.play("idle")

			move_and_slide()



	

func bounce():
	velocity.y = 0.8 * JUMP_VELOCITY

func Death():
	print('death')
	is_dead = true
	velocity.x = 0
	velocity.y = 0
	
	$HurtSound.play()
	anim.play("die")
	await anim.animation_finished
	hide()
	get_parent().Game_Over()

func _on_hurtbox_2_body_entered(body):
	
	Death()
	
	
func stop_moving():
	velocity.x = 0
	anim.stop()
	move = false
	
func moving():
	move = true
	
func Die():
	velocity.x = move_toward(velocity.x, MAX_SPEED, ACCEL)
	await get_tree().create_timer(1.5).timeout
	Die()
	



