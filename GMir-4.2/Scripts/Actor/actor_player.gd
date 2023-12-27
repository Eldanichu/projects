extends GameActor
class_name ActorPlayer

signal spawnd()
signal stats_change()
signal on_level_up()
signal on_attack()
signal on_dead()

var _actor_class:ActorClass

func _init():
	super(PlayerStat.new())
	self.on_level_up.connect(update_prop)
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

func set_hp_t(value:int):
	super(value)
	stats_change.emit()

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
	if not mon_obj:
		return
	var d := Damage.new()
	d.set_dmg_type(DamageType.E.ATK).set_source(self).set_target(mon_obj)
	d.build()

func level_up(direct:bool = false):
	super(direct)
	on_level_up.emit()

func update_prop():
	if not _actor_class:
		return
	_actor_class.update_props()

func update_class_prop():
	update_prop()
	stats_change.emit()
