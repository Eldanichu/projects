extends Resource
class_name SkillObject

const instance_props:Array = [
	"_uid",
	"id",
	"type",
	"icon",
	"cd",
	"damage_prop",
	"cast",
	"target",
]

var _uid:String
var id setget set_id
var type
var item_type:int = Globals.ITEM_TYPE.SPELL
var icon:String
var cd:float
# set which property as damage calculation
var damage_prop:String
var properties:Dictionary = {}
var cast
var target

var useable:bool = true
var pickable:bool = false

var buff_names:Array = []
var animation_id:String

var skill_inst

func _init():
	_uid = StringUtil.gen_id()

func get_instance():
	match id:
		"default_attack":
			var skill_object := DefaultAttack.new()
			set_object(skill_object.to_object())
			skill_inst = skill_object

func set_object(obj:Dictionary):
	for key in obj:
		if key in self:
			self[key] = obj[key]

func to_object() -> Dictionary:
	var _props:Dictionary = {}
	for key in instance_props:
		_props[key] = self[key]
	_props.merge(properties, true)
	return _props

func set_id(id_):
	id = id_

func exist():
	if skill_inst:
		return true
	return false
