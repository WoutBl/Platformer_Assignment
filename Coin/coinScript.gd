extends Area2D
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$PickupCoin.play()
			get_parent().HUD_update_score()
			hide()
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
		else:
			pass

