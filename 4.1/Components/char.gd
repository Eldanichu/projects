extends GridContainer
class_name Charecter

const ITEM_PREIFX:String = "char_item_"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate():
	pass
	
func equip_on():
	pass

func equip_out():
	pass
	
func has_item():
	pass

func get_item(slot:Node, item_name:String):
	var _item_name = "{0}{1}".format([ITEM_PREIFX, item_name])
	var _node = slot.get_node_or_null(_item_name)
	return _node

func get_slot(slot_id:String):
	var _slot = get_node_or_null(slot_id)
	return _slot

