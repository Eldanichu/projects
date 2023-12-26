extends GameActor
class_name ActorPlayer

signal spawnd()
signal stats_change()
signal on_attack()
signal on_dead()

var _actor_class:ActorClass

func _init():
	super(PlayerStat.new())
	spawnd.emit()
	stats_change.emit()

func set_class(actor_class:ActorClass):
	if actor_class.is_class_name("TaoClass"):
		_actor_class = actor_class
		update_class_prop()
#	elif actor_class.is_class_name("WarClass"):
#		actor_class = WarClass.new(stats)
#	elif actor_class.is_class_name("WizClass"):
#		actor_class = WizClass.new(stats)

func dead():
	super()
	if is_dead():
		on_dead.emit()

func set_hp(value:int, max_value:int = -1):
	super(value, max_value)
	stats_change.emit()

func set_atk(value:int):
	stats.ATK = value
	stats_change.emit()

func set_def(value:int):
	stats.DEF = value
	stats_change.emit()

func attack(mon_obj:MonObject):
	print(mon_obj)
	if not mon_obj:
		return
	mon_obj.set_hp_t(-1)

func level_up(direct:bool = false):
	super(direct)
	stats_change.emit()

func update_class_prop():
	if not _actor_class:
		return
	_actor_class.update_props()
	stats_change.emit()
