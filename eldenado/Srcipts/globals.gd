extends Resource
class_name Globals

const hp_const = 14;
const mp_const = 13;
const exp_const = 14
const exp_factor = 1.1

const CLASS_TYPE:Dictionary = {
	Wizard = 1,
	Taos = 2,
	Warrior = 0
}

const CLASS_NAME:Dictionary = {
	1 : "TAG_CLASS_WIZARD",
	2 : "TAG_CLASS_TAO",
	0 : "TAG_CLASS_WARRIOR"
}

const wizard:Dictionary = {
	"hp_base":15,
	"hp_acc":1.8,
	"mp_base":5,
	"mp_acc":2,
	"mp_rate":2.2
}

const taos:Dictionary = {
	"hp_base":6,
	"hp_acc":2.5,
	"mp_base":5,
	"mp_acc":8,
	"mp_rate":2.2
}

const warrior:Dictionary = {
	"hp_base":4,
	"hp_acc":4.5,
	"hp_cc":20,
	"mp_base":3.5,
}

const char_display_stat:Array = [
	"hp",
	"hp_max",
	"mp",
	"mp_max",
	"expr",
	"expr_max",
	"level",
	"gold",
	"class_type",
]

const char_panel_stat:Array = [
	"crit_strength",
	"crit_chance",
	"crit_mag_strength",
	"crit_mag_chance",
	"ac",
	"ac_mac",
	"mc",
	"mc_max",
	"dc",
	"dc_max",
	"sc",
	"sc_max"
]

const ITEM_QTY:Dictionary = {
	COMMON = 9,
	MAGIC = 8,
	RARE = 7,
	SET = 6,
	EPIC = 5,
	LEGENDARY = 4
}

const ITEM_TYPE:Dictionary = {
	CONSUMABLE = 31,
	POSION = 2,

	HELM = 2,
	WEAPON = 3,
	SHIELD = 13,
	CHEST = 10,

	AMULET = 4,
	BRACE = 5,
	RING = 6,

	BELT = 11,
	BOOT = 12,
	SPELL_ITEM = 32,
	ATTACH = 33,

	SPELL = 24,
	TASK = 0,
	SCROLL = 30,
	MATERIAL = 32
}

static func get_class_stats(level:int,class_index:int = 0) -> Dictionary:
	var max_hp;
	var max_mp;
	if class_index == CLASS_TYPE.Warrior:
		max_hp = hp_const + (int(level / warrior.hp_base + warrior.hp_acc + level / warrior.hp_cc) * level);
		max_mp = round(level * warrior.mp_base);
	elif class_index == CLASS_TYPE.Wizard:
		max_hp = hp_const + (int(level / wizard.hp_base + wizard.hp_acc) * level);
		max_mp = round(mp_const + (int(level / wizard.mp_base + wizard.mp_acc) * wizard.mp_rate * level))
	elif class_index == CLASS_TYPE.Taos:
		max_hp = hp_const + (int(level / taos.hp_base + taos.hp_acc) * level);
		max_mp = round(mp_const + (int(level / taos.mp_base + taos.mp_acc) * taos.mp_rate * level))
	return {
		"max_hp":max_hp,
		"max_mp":max_mp
	};

static func get_exp_by_level(level:int) -> int:
	var time:int = level * 2 + 5
	var exp_value:int = level * ( exp_const * exp_factor ) * time
	return exp_value

