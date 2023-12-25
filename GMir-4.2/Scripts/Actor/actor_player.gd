extends GameActor
class_name ActorPlayer

var _actor_class:ActorClass

func _init():
	super(PlayerStat.new())
	P.spawn.emit()
	S.stats_changed.emit()
	P.levelup.connect(update_class_prop)

func set_class(actor_class:ActorClass):
	if actor_class.is_class_name("TaoClass"):
		_actor_class = actor_class
#	elif actor_class.is_class_name("WarClass"):
#		actor_class = WarClass.new(stats)
#	elif actor_class.is_class_name("WizClass"):
#		actor_class = WizClass.new(stats)

func update_class_prop():
	if not _actor_class:
		return
	_actor_class.update_props()
