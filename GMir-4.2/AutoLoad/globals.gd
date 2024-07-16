extends Node

var r := RandomEx.get_instance()

const MAX_HIT_CHANCE = 90
const MON_INSTANCE_PREFIX = "mon_instance@{0}"

### ---------------------------------------------------------------------------

const DIC_CHAR_PROP = {
	"hp":{ "label":"HP", "key":"hp" ,"group":"0" },
	"hp_max":{ "label":"MAX HP", "key":"hpmax" ,"group":"0" },
	"mp":{ "label":"MP", "key":"mp" ,"group":"0" },
	"mp_max":{ "label":"MAX MP", "key":"mpmax" ,"group":"0" },
	"expv":{ "label":"EXP", "key":"expv" ,"group":"0" },
	"expv_max":{ "label":"MAX EXP", "key":"expvmax" ,"group":"0" },
	"level":{ "label":"LEVEL", "key":"level" ,"group":"0" },
	"ac":{ "label":"AC", "key":"ac" ,"group":"0" },
	"mac":{ "label":"MAC", "key":"mac" ,"group":"0" },
	"dr":{ "label":"Damage Reduction", "key":"dr" ,"group":"0" },
	"dc":{ "label":"DC", "key":"dc" ,"group":"0" },
	"dcc":{ "label":"DC MAX", "key":"dcc" ,"group":"0" },
	"ar":{ "label":"Aumour Resistence", "key":"ar" ,"group":"0" },
	"mar":{ "label":"MAR", "key":"mar" ,"group":"0" },
	"mc":{ "label":"Magic Damage", "key":"mc" ,"group":"0" },
	"agi":{ "label":"Agi", "key":"agi" ,"group":"0" },
	"mod":{ "label":"Damage Modification", "key":"mod" ,"group":"0" },
	"mf":{ "label":"Magic Find", "key":"mf" ,"group":"0" },
	"lck":{ "label":"Luck", "key":"lck" ,"group":"0" },
}
