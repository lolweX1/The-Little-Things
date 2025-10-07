extends Node

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
