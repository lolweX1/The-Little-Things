extends Control

# note: the variables labelled old is made to improve performance, if no changes are made to the variables, there is no need to update anything

# nodes
@onready var wish_bar = $Wish_bg
@onready var wish_prog = $Wish_bg/wish_progress
@onready var wish_prog_txt = $Wish_bg/prog
@onready var level_lb = $level
@onready var player = tasks.root.get_node("Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var panel_stylebox = wish_bar.get_theme_stylebox("panel")
	player_stats.max_wish_size = wish_bar.size.x - panel_stylebox.get_margin(SIDE_LEFT) * 2;
	
	wish_prog_txt.text = str(player_stats.wish) + "/" + str(player_stats.wish_max[player_stats.level])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (player_stats.wish != player_stats.old_wish):
		player_stats.wish_size = clamp(player_stats.max_wish_size * (player_stats.wish/player_stats.wish_max[player_stats.level]), 3, player_stats.max_wish_size)
		wish_prog.size.x = player_stats.wish_size
		player_stats.old_wish = player_stats.wish
		
		if (player_stats.wish > player_stats.wish_max[player_stats.level]):
			player_stats.wish = 0
			player_stats.level += 1
		
		wish_prog_txt.text = str(player_stats.wish) + "/" + str(player_stats.wish_max[player_stats.level])
	if (player_stats.level != player_stats.old_level):
		player_stats.old_level = player_stats.level
		level_lb.text = "player_stats.level " + str(player_stats.level)
