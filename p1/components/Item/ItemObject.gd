extends Node
class_name ItemObject

enum ItemType {
    POSION = 0,
    GEAR = 9,
    CONSUME = 33,
    STACK = 99
}

enum ItemLevel {
    BROKEN = 0,
    SUPERB = 1,
    MAGIC = 2,
    RARE = 3,
    UNIQUE = 4,
    MYTHUNI = 5,
    LEGEND = 6,
    MYSTICAL = 7,
    HEROIC = 55
}

enum ItemEffect {
    
}

var oItem = {}

var ItemProperty := {
    "RING":{
        "DC":[0,10],
        "MC":[],
        "SC":[],
        "RMP":[],
        "RHP":[],
        "AR":[],
    },
    "CHEST":{
        "DC":[0,10],
        "MC":[],
        "SC":[],
        "RMP":[],
        "RHP":[],
        "AC":[],
        "AMC":[]
    }
}


func set_type(type):
    oItem["type"] = ItemProperty[type]

func set_level(level):
    for ilvl in ItemLevel:
        if(level == ItemLevel[ilvl]):
            oItem["level"] = ilvl

func set_icon(icon_name:String):
    var item_icons := ItemIcons.new()
    var _icon = item_icons.get_icon(icon_name)
    if(!_icon):
        print_debug("icon does not exist");
        return null;
    oItem["icon"] = item_icons.get_icon(icon_name)

func use_item():
    pass

func stringify():
    return str(oItem)
