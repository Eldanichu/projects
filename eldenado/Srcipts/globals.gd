extends Resource
class_name Globals

const hp_const = 14;
const mp_const = 13;
const exp_const = 14
const exp_factor = 1.1

enum SLOT_TYPE {
	EMPTY = -1,
	SKILL = 0,
	EQUIP = 1,
	SKILL_ITEM = 2,
	USEABLE_ITEM = 3,
	MATERIAL = 4,
}

enum SLOT_ACTION {
	USE = 1,
	MOVE = 2
}

enum ITEM_SOURCE {
	UNKNOWN = -4,
	SKILL_LIST = 1024,
	SKILL_BAR = 980,
	INVENTORY = 800,
	EQUIPMENT = 720
}

enum PLAYER_STATE {
	BATTLE,
	IDEL,
}

enum BATTLE_STATUS {
	WAIT = -4
	FIGHT = -1,
	FAIL = 0,
	WIN = 1,
}

enum DAMAGE_TYPE {
	SPELL = 0,
	ATTACK = 1
}

const PATH_TYPE = {
	1:"Items",
	0:"Skill/icon"
}


const SLOT_RULES:Dictionary = {
	ITEM_SOURCE.SKILL_LIST : [ ITEM_SOURCE.SKILL_BAR ],
	ITEM_SOURCE.INVENTORY : [ ITEM_SOURCE.EQUIPMENT, ITEM_SOURCE.SKILL_BAR ],
	ITEM_SOURCE.EQUIPMENT : [ ITEM_SOURCE.INVENTORY ],
}

const CLASS_TYPE:Dictionary = {
	Wizard = 1,
	Taos = 2,
	Warrior = 0
}

const ITEM_QTY:Dictionary = {
	COMMON = 9,
	MAGIC = 8,
	RARE = 7,
	SET = 6,
	EPIC = 5,
	LEGENDARY = 4
}

const ITEM_TYPE:Dictionary = {


	HELM = 2,
	WEAPON = 3,
	SHIELD = 13,
	CHEST = 10,

	AMULET = 4,
	BRACE = 5,
	RING = 6,

	BELT = 11,
	BOOT = 12,
	SPELL_ITEM = 34,
	ATTACH = 33,

	CONSUMABLE = 31,
	POSION = 2,
	SPELL = 24,
	SCROLL = 30,
	TASK = 0,
	MATERIAL = 32
}

static func is_equipment(item_type):
	return [3,13,10,4,5,6,11,12,33,34].has(item_type)
static func is_use_item(item_type):
	return [31,2,0,30].has(item_type)
static func is_spell(item_type):
	return [24].has(item_type)
static func is_fixed(item_type):
	return [0,32].has(item_type)

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
	"mp_rate":2.2,
	"mc_base":0.24,
	"mc_rate":0.12
}

const taos:Dictionary = {
	"hp_base":6,
	"hp_acc":2.5,
	"mp_base":5,
	"mp_acc":8,
	"mp_rate":2.2,
	"sc_base":0.24,
	"sc_rate":0.15
}

const warrior:Dictionary = {
	"hp_base":4,
	"hp_acc":4.5,
	"hp_cc":20,
	"mp_base":3.5,
	"dc_base":0.23,
	"dc_rate":0.11
}

const char_display_stat:Array = [
	"hp",
	"hp_max",
	"mp",
	"mp_max",
	"expr",
	"expr_max",
	"level",
	"class_type",
]

const char_panel_stat:Array = [
	["ac","","防御"],
	["mac","","魔御"],
	["dc-dc_max","","攻击"],
	["mc-mc_max","","魔法"],
	["sc-sc_max","","道术"],
	["crit_strength","","暴击强度"],
	["crit_chance","%","暴击率"],
	["crit_mag_strength","","魔法暴击强度"],
	["crit_mag_chance","%","魔法暴击率"],
]

const PLAYER_DEFAUT_ITEMS:Array = [
	{"id":"posion_hp_0", "size":5},
	{"id":"posion_mp_0", "size":5},
	{"id":"posion_rjuv_0", "size":5},
]

const SKILL_SLOT:Dictionary = {
	ATTACK = "Attack",
	DEFAULT_SKILL = "Skill",
	SLOT_1 = "Skill 1",
	SLOT_2 = "Skill 2",
	SLOT_3 = "Skill 3",
	SLOT_4 = "Skill 4",
	SLOT_5 = "Skill 5",
	SLOT_6 = "Skill 6",
	SLOT_7 = "Skill 7",
	SLOT_8 = "Skill 8",
}

static func get_class_stats(level:int,class_index:int = 0) -> Dictionary:
	var max_hp
	var max_mp

	if class_index == CLASS_TYPE.Warrior:
		max_hp = hp_const + (int(level / warrior.hp_base + warrior.hp_acc + level / warrior.hp_cc) * level)
		max_mp = round(level * warrior.mp_base)
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

static func can_slot_put(item:SlotObject, slot:SlotObject) -> bool:
	var b = false
	if slot == null:
		return b
	var _item_from = item.from
	var _slot_from = slot.from
	if not _item_from in SLOT_RULES:
		printerr("[can_put]->Error: Unknown Item Slot Rule!")
		return b
	var rule:Array = SLOT_RULES[_item_from]
	if rule.has(_slot_from):
		b = true
	return b
