extends RefCounted
class_name DamageType

class Private:
	const dt:Dictionary = {
		0x01:[
			"ATTACK"
		],
		0x02:[
			"RFIRE","RICE","RWIND","RWATER","RATTACK"
		],
		0x03:[
			"DFIRE","DICE","DWIND","DWATER"
		],
		0x04:[
			"DFIRE","DICE","DWATER"
		],
		0x05:[
			"MAGIC","DWIND"
		]
	}
	
	var type:int = 0x00
	
	func _init():
		pass
		
	func get_type() -> Array:
		if type in dt:
			return dt[type]
		return []

var _Private:Private

func _init():
	_Private = Private.new()

func PHYSICAL() -> DamageType:
	_Private.type = 0x01
	return self
func  DEFENCE()-> DamageType:
	_Private.type =  0x02
	return self
func  OFFENCE()-> DamageType:
	_Private.type = 0x03
	return self
func  ELEMENT()-> DamageType:
	_Private.type =  0x04
	return self
func  MAGIC()-> DamageType:
	_Private.type =  0x05
	return self

func get_type():
	return _Private.get_type()


