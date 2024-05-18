extends Node

var r := RandomEx.get_instance()

const MAX_HIT_CHANCE = 90
const MON_INSTANCE_PREFIX = "mon_instance@{0}"


func get_instance_mon_name() -> String:
	return MON_INSTANCE_PREFIX.format([r.uid(5)])

### ---------------------------------------------------------------------------

const DIC_CHAR_PROP = {
	"hp":{ "label":"", "key":"hp" ,"group":"0" },
	"hp_max":{ "label":"", "key":"hp_max" ,"group":"0" },
	"mp":{ "label":"", "key":"mp" ,"group":"0" },
	"mp_max":{ "label":"", "key":"mp_max" ,"group":"0" },
	"expv":{ "label":"", "key":"expv" ,"group":"0" },
	"expv_max":{ "label":"", "key":"expv_max" ,"group":"0" },
	"level":{ "label":"", "key":"level" ,"group":"0" },
	"ac":{ "label":"", "key":"ac" ,"group":"0" },
	"mac":{ "label":"", "key":"mac" ,"group":"0" },
	"dr":{ "label":"", "key":"dr" ,"group":"0" },
	"dc":{ "label":"", "key":"dc" ,"group":"0" },
	"dcc":{ "label":"", "key":"dcc" ,"group":"0" },
	"ar":{ "label":"", "key":"ar" ,"group":"0" },
	"mar":{ "label":"", "key":"mar" ,"group":"0" },
	"mc":{ "label":"", "key":"mc" ,"group":"0" },
	"agi":{ "label":"", "key":"agi" ,"group":"0" },
	"mod":{ "label":"", "key":"mod" ,"group":"0" },
	"mf":{ "label":"", "key":"mf" ,"group":"0" },
	"lck":{ "label":"", "key":"lck" ,"group":"0" },
}
