extends Resource

enum ITEM_TYPE{
	COMMON = 9,
	RARE = 4,
	EPIC = 1,
}

## [0] name | [1] pty | [2] tc | [3] rv
export var Items:Array = [
		[ "Posion 1", 2, 1, ITEM_TYPE.COMMON ],
		[ "Posion 2", 8, 1, ITEM_TYPE.COMMON ],
		[ "Posion 3", 15, 1, ITEM_TYPE.COMMON ],
		[ "Epic Aumor", 30, 30, ITEM_TYPE.EPIC ],
		[ "Common Weapon", 15, 10, ITEM_TYPE.COMMON ],
		[ "Rare Aumor", 50, 20, ITEM_TYPE.RARE ],
	]
