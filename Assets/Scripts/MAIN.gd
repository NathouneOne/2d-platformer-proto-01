extends Node

const SAVE_PATH = "user://FallingCube_saveFile.save"

## LOADING SCENES
const ESC_SCREEN = preload("uid://crgbo6r4vnr3v")
const WELCOME_SCREEN = preload("uid://d4lcsj5yhdf7n")
const GAME = preload("uid://dhi4esrgo13w")
const END_LEVEL_SCREEN = preload("uid://nav4fo21ldex")
const END_GAME_SCREEN = preload("uid://cvjxhoyh3isle")
const LEVEL_SELECTION_SCREEN = preload("uid://bk6fgtrn4x1ky")


var esc_screen = ESC_SCREEN.instantiate()
var welcome_screen = WELCOME_SCREEN.instantiate()
var game = GAME.instantiate()
var end_game_screen = END_GAME_SCREEN.instantiate()
var end_level_screen = END_LEVEL_SCREEN.instantiate()
var level_selection_screen = LEVEL_SELECTION_SCREEN.instantiate()

var max_level_index = 0

var camera = Node

@export var levels : Array[PackedScene] 
var current_level : Node
var current_level_index = 0

var end_level_screen_flag = 0

var best_score : Array[float]
var game_ended =0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	load_save_file()
	
	
	add_child(welcome_screen)
	add_child(level_selection_screen)
	level_selection_screen.hide()
	
	welcome_screen.get_child(1).pressed.connect(select_level)
	welcome_screen.get_child(2).pressed.connect(select_level)
	welcome_screen.get_child(3).pressed.connect(level_select_screen_init)
	
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	add_child(end_level_screen)
	end_level_screen.get_child(1).pressed.connect(next_level)
	end_level_screen.get_child(2).pressed.connect(restart_level)
	end_level_screen.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	##handle pause on esc
	if Input.is_action_just_pressed("esc"):
		if not game_ended and (not end_level_screen_flag):
			if get_child(1).name == "GAME" :
				get_tree().paused = not get_tree().paused
				game.visible = not game.visible
				esc_screen.visible = not esc_screen.visible
	
	


func store_best_score(time):

	if best_score.size() < current_level_index+1:
		best_score.append(time)
	elif time<best_score[current_level_index] :
		best_score[current_level_index] = time
	
	if current_level_index+1 > max_level_index and current_level_index<levels.size()-2:
		max_level_index=current_level_index+1
	update_save_file()

func update_save_file() :
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var save_dict = {
		"best_score" : best_score, 
		"max_level_index" : max_level_index
	}
	save_file.store_var(save_dict)

func load_save_file() :
	if FileAccess.file_exists(SAVE_PATH) :
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var save_dict = file.get_var()
		best_score = save_dict["best_score"]
		max_level_index = save_dict["max_level_index"]
		

func _reset_save_file() :
	OS.move_to_trash(ProjectSettings.globalize_path(SAVE_PATH))
	best_score.resize(0)


func next_level() :
	end_level_screen_flag = 0
	end_level_screen.hide()
	game.show()
	game.game_just_started = 1
	get_tree().paused = false
	
	if current_level_index < levels.size()-1 :
		current_level_index+=1
		
		var level_name = current_level.name
		for i in game.get_child_count() :
			if game.get_child(i).name == level_name :
				game.get_child(i).queue_free()

		current_level=levels[current_level_index].instantiate()
		
		if current_level.need_slowmo_at_start :
			game.level_need_slowmo_at_start =1
			
		game.add_child(current_level)
		game.reload_level()
	
	
	else :
		game_ended=1
		game.queue_free()
		esc_screen.queue_free()
		add_child(end_game_screen)
		get_tree().paused = true
	

func level_finished() :
	end_level_screen_flag = 1
	end_level_screen.show()
	game.hide()
	
	camera.global_position = Vector2(0.0,0.0)
	camera.reset_smoothing()
	get_tree().paused = true
	
func restart_level() :
	current_level_index -=1
	next_level()


func level_select_screen_init():
	
	level_selection_screen.show()
	welcome_screen.hide()
	
	level_selection_screen.get_child(1).pressed.connect(select_level)
	level_selection_screen.get_child(2).pressed.connect(select_level)
	level_selection_screen.get_child(3).pressed.connect(select_level)
	level_selection_screen.get_child(4).pressed.connect(select_level)
	level_selection_screen.get_child(5).pressed.connect(select_level)
	level_selection_screen.get_child(6).pressed.connect(select_level)
	

func select_level() :
	add_child(game)
	camera = game.get_node("Player/Camera2D")
	
	if levels.size() :
		current_level=levels[current_level_index].instantiate()
		game.level_need_slowmo_at_start = current_level.need_slowmo_at_start
		game.add_child(current_level)
		game.game_just_started = 1
		game.reload_level()
	
	game.level_finished_signal.connect(level_finished.bind())
	
	
	add_child(esc_screen)
	esc_screen.get_child(2).pressed.connect(_reset_save_file)
	esc_screen.hide()
	
	welcome_screen.queue_free()
	level_selection_screen.queue_free()
