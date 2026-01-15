extends Node

var best_score = null
var is_launched = 0
var death_sound = preload("uid://1wmdrd0svocb")
var win_sound = preload("uid://dacwlrdkgp3hh")


var SFX_player := AudioStreamPlayer2D.new() 

func _ready() -> void:
	add_child(SFX_player)


func store_best_score(time):
	if best_score == null or time<best_score :
		best_score = time
	print(best_score)



func death(sound = null):
	var timer := Timer.new()
	add_child(timer)
	timer.one_shot=true
	timer.wait_time = 0.15
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	Engine.time_scale=0.1
	
	if sound != null :
		if sound == "Death" :
			SFX_player.stream = death_sound
			SFX_player.play()
		if sound == "Win" :
			SFX_player.stream = win_sound
			SFX_player.play()
			

func _on_timer_timeout() -> void:
		Engine.time_scale=1
		get_tree().reload_current_scene()
