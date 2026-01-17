extends Node


## LOADING SCENES
const ESC_SCREEN = preload("uid://crgbo6r4vnr3v")
const WELCOME_SCREEN = preload("uid://d4lcsj5yhdf7n")
const GAME = preload("uid://dhi4esrgo13w")

var esc_screen = ESC_SCREEN.instantiate()
var welcome_screen = WELCOME_SCREEN.instantiate()
var game = GAME.instantiate()

@export var levels : Array[PackedScene] 

var best_score = null




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(welcome_screen)
	welcome_screen.get_child(1).pressed.connect(_welcome_screen_button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	##handle pause on esc
	if Input.is_action_just_pressed("esc"):
		if get_child(0).name == "GAME" :
			get_tree().paused = not get_tree().paused
			game.visible = not game.visible
			esc_screen.visible = not esc_screen.visible
			
	


func _welcome_screen_button() :
	add_child(game)
	if levels.size() :
		game.add_child(levels[0].instantiate())
		add_child(esc_screen)
	esc_screen.hide()
	welcome_screen.queue_free()
	

func store_best_score(time):
	if best_score == null or time<best_score :
		best_score = time
