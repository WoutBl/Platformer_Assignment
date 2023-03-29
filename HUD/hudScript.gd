extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.hide()
	$ScoreLabel2.hide()
	$TextureRect.hide()
	$XLabel.hide()
	$DeathLabel.hide()
	$WinLabel.hide()
	$NoCoinsLabel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_score(score):
	
	print(score)
	if score >= 10:
		$ScoreLabel2.hide()
	$ScoreLabel.text = str(score)
	
func _on_StartButton_pressed():
	$Start_btn.hide()
	$TitelLabel.hide()
	$MainMenuBackground.hide()
	emit_signal("start_game")
	$ScoreLabel.show()
	$ScoreLabel2.show()
	$TextureRect.show()
	$XLabel.show()
	
func Game_over():
	$DeathLabel.show()
	$NoCoinsLabel.hide()
	
func Win():
	$WinLabel.show()
	
func NotEnoughCoins():
	$NoCoinsLabel.show()
