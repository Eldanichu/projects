extends Node

var imgs = {
	"003":preload("res://Assets/Monsters/Images/003.png"),
	"004":preload("res://Assets/Monsters/Images/004.png"),
	"005":preload("res://Assets/Monsters/Images/005.png"),
	"006":preload("res://Assets/Monsters/Images/006.png"),
	"007":preload("res://Assets/Monsters/Images/007.png"),
}

"""
[1] NAME
[2] LEVEL
[3] ATTACK_SPEED
[4] DC
[5] DC_MAX
[6] AC
[7] AC_MAX
[8] HP
[9] appr
"""
const data:Dictionary = {
	"003": ["chicken", 5, 800, 1, 4, 0, 1, 5, "003"],
	"004": ["dier", 6, 800, 3, 5, 1, 1, 12, "004"],
	"005": ["dum_0", 7, 800, 3, 5, 0, 1, 12, "005"],
	"009": ["arc_0", 7, 800, 2, 8, 1, 2, 22, "009"],
	"006": ["cat_1", 7, 800, 2, 6, 1, 2, 23, "006"],
	"007": ["cat_2", 7, 800, 2, 6, 1, 2, 25, "007"],
	"011": ["snow_man", 7, 800, 5, 10, 2, 4, 30, "011"],
	"012": ["spider", 7, 700, 6, 9, 1, 4, 42, "012"]
}
