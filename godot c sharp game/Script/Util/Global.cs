using System;

public static class Global {
  public enum PROP_TYPE {
    ATTACK,
    DEFENCE,
    STAT
  }
  public enum CLASS_TYPE {
    warrior = 0,
    wizard = 1,
    tao = 2
  }

  public enum PLAYER_STATE {
    ATTACK,
    CAST,
    DAMAGE,
    USEITEM,
    SHOP
  }

  public enum PLAYER_ABILITY {
    LEVEL,
    EXP,
    DEF,
    ATK,
    HP,
    MP,
    DEAD
  }
  
  public enum TILE_TYPE {
    INVALID = -1,
    PLAYER = 1,
    MONSTER = 0,
    OB = 9,
    BUILDING = 2
  }
}
