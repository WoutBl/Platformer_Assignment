extends Node2D
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	hide()
	$enemy.stop_moving()
	$Player.stop_moving()
	





func _on_killplane_body_entered(body):
	print(body)
	body.Death()
	
	
func show_win():
	pass

func HUD_update_score():
	score += 1
	$HUD.update_score(score)

func Game_Over():
	$BackgroundMusic.stop()
	print("game Over")
	$HUD.Game_over()
	await get_tree().create_timer(2).timeout
	get_tree().reload_current_scene()


func _on_hud_start_game():
	show()
	$enemy.moving()
	$Player.moving()
	$Finish/GhostSprite.play("fly")


func _on_finish_body_entered(body):
	print("win")
	print(body)
	if score == 10:
		print("player")
		$Player.stop_moving()
		$HUD.Win()
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()
	else:
		$Player.stop_moving()
		$HUD.NotEnoughCoins()
		await get_tree().create_timer(.5).timeout
		$Player.moving()
		$Player.Die()
