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
	"posion_hp_0"   : [ 1, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00398", ["healhp"], {"step":2,"interval":7} ],
	"posion_hp_1"   : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00400", ["healhp"], {"step":4,"interval":7}  ],
	"posion_mp_0"   : [ 1, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00394", ["healmp"], {"step":4,"interval":7}  ],
	"posion_mp_1"   : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00396", ["healmp"], {"step":8,"interval":7}  ],
	"posion_rjuv_0" : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.POSION, "00312", ["heal_instant"], {"hp":20,"mp":35}  ],
	"wood_sword" : [ 5, ITEM_QTY.COMMON, ITEM_TYPE.WEAPON, "00312"  ],
}
