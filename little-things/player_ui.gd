extends Control

# note: the variables labelled old is made to improve performance, if no changes are made to the variables, there is no need to update anything

# nodes
@onready var wish_bar = $Wish_bg
@onready var wish_prog = $Wish_bg/wish_progress
@onready var wish_prog_txt = $Wish_bg/prog
@onready var level_lb = $level
@onready var player = tasks.root.get_node("Main/Player")

# level
var level = 0
var old_level = 0

# willpower
var willpower = 0

# wish
var wish_max = [ # wish_max formula is: 100 + (fibonacchi number) * 10
	100,
	110,
	110,
	120,
	130,
	150,
	180,
	230,
	310,
	440
]
var wish = 0.0
var old_wish = 0;

# wish bar
var min_wish_size = 3
var max_wish_size
var wish_size = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var panel_stylebox = wish_bar.get_theme_stylebox("panel")
	max_wish_size = wish_bar.size.x - panel_stylebox.get_margin(SIDE_LEFT) * 2;
	
	wish_prog_txt.text = str(wish) + "/" + str(wish_max[level])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (wish != old_wish):
		wish_size = clamp(max_wish_size * (wish/wish_max[level]), 3, max_wish_size)
		wish_prog.size.x = wish_size
		old_wish = wish
		
		if (wish > wish_max[level]):
			wish = 0
			level += 1
		
		wish_prog_txt.text = str(wish) + "/" + str(wish_max[level])
	if (level != old_level):
		old_level = level
		level_lb.text = "level " + str(level)
