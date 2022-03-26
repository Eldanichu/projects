extends Resource
class_name Globals

const hp_const = 14;
const mp_const = 13;
const exp_const = 14
const exp_factor = 1.1

enum ClassType {
  Wizard = 1,
  Taos = 2,
  Warrior = 0
}

var wizard:Dictionary = {
  "hp_base":15,
  "hp_acc":1.8,
  "mp_base":5,
  "mp_acc":2,
  "mp_rate":2.2
}

var taos:Dictionary = {
  "hp_base":6,
  "hp_acc":2.5,
  "mp_base":5,
  "mp_acc":8,
  "mp_rate":2.2
}

var warrior:Dictionary = {
  "hp_base":4,
  "hp_acc":4.5,
  "hp_cc":20,
  "mp_base":3.5,
}

func get_class_stats(level:int,class_index:int = 0) -> Dictionary:
  var max_hp;
  var max_mp;
  if class_index == ClassType.Warrior:
    max_hp = hp_const + (int(level / warrior.hp_base + warrior.hp_acc + level / warrior.hp_cc) * level);
    max_mp = round(level * warrior.mp_base);
  elif class_index == ClassType.Wizard:
    max_hp = hp_const + (int(level / wizard.hp_base + wizard.hp_acc) * level);
    max_mp = round(mp_const + (int(level / wizard.mp_base + wizard.mp_acc) * wizard.mp_rate * level))
  elif class_index == ClassType.Taos:
    max_hp = hp_const + (int(level / taos.hp_base + taos.hp_acc) * level);
    max_mp = round(mp_const + (int(level / taos.mp_base + taos.mp_acc) * taos.mp_rate * level))
  return {
    "max_hp":max_hp,
    "max_mp":max_mp
  };


func get_exp_by_level(level:int) -> int:
  var time:int = level * 2 + 5
  var exp_value:int = level * ( exp_const * exp_factor ) * time
  return exp_value

