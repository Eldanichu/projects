using System;
using Godot;
using Godot.Collections;
using godotcsharpgame.Script.Util;

namespace godotcsharpgame.Script.Object.Inventory {
  public class Inventory : PanelContainer {
    [Export]
    public int Slots { get; set; } = 42;

    [Export]
    public PackedScene SlotObject { set; get; }

    public Dictionary<Vector2, Slot> InvGrid;
    public Vector2 SlotRange { private set; get; }
    private GridContainer grid;
    private ScrollContainer scroll;

    public override void _Ready() {
      grid = GetNode<GridContainer>("%grid");
      scroll = GetNode<ScrollContainer>("%scroll");

      CreateSlots();
    }

    public Slot GetSlot(Vector2 position) {
      if (SlotRange.x > position.x || SlotRange.y > position.y) {
        throw new Exception($"Slot Positions is out of range;");
      }
      var _slot = InvGrid[position];
      return _slot;
    }

    public void OnPickItem(Slot slot) {
      L.t($"{slot.PositionS}");
    }
    
    private void CreateSlots() {
      InvGrid = new Dictionary<Vector2, Slot>();
      var cols = grid.Columns;
      int yIndex = 0;
      int xIndex = 0;
      for (int i = 0; i < Slots; i++) {
        var _slot = (Slot)SlotObject.Instance();
        grid.AddChild(_slot);
        _slot.Connect("PickItem", this, "OnPickItem");
        if (i % cols == 0) {
          xIndex = 0;
          ++yIndex;
        }

        var pos = new Vector2(xIndex, yIndex);
        InvGrid.Add(pos, _slot);
        _slot.PositionS = pos;
        ++xIndex;
      }

      SlotRange = new Vector2(xIndex, yIndex);
    }
  }
}
