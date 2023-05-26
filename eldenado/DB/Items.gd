extends Node
const ITEM_TYPE = Globals.ITEM_TYPE
const ITEM_QTY = Globals.ITEM_QTY
"""
[1] TC
[2] RARE_VALUE
[3] ITEM_TYPE
[4] ICON
[5] EFFECT_NAME
[6] PROPERTIES
"""
const data:Dictionary = {
	"posion_hp_0"   : [ 1, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00398", ["heal"] ],
	"posion_hp_1"   : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00400", ["heal"]  ],
	"posion_mp_0"   : [ 1, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00394", ["heal"]  ],
	"posion_mp_1"   : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00396", ["heal"]  ],
	"posion_rjuv_0" : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00312", ["heal"]  ],
	"wood_sword" : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.WEAPON, "00312"  ],
}
