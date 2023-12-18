extends Node

var r := RandomEx.get_instance()

const MAX_HIT_CHANCE = 90
const STATS_DEFAULT_UPDATE_EVENT = "DEFAULT_STATS_UPDATE"
const PLAYER_STATS_UPDATE_EVENT = "PLAYER_STATS_UPDATE"
const MONSTER_STATS_UPDATE_EVENT = "MON_STATS_UPDATE"
const MON_INSTANCE_PREFIX = "mon_instance@{0}"


func get_instance_mon_name() -> String:
	return MON_INSTANCE_PREFIX.format([r.uid(5)])
