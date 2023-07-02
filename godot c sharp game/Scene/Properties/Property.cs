using Godot;
using System;
using System.Collections.Generic;
using Array = Godot.Collections.Array;

public class Property : PanelContainer {
  [Export] public PackedScene PropertyItem;

  private Dictionary<string, string> _properties;

  public Dictionary<string, string> Properties {
    set {
      _properties = value;
      if (!IsInsideTree()) {
        return;
      }

      CreateProperties();
      UpdateProperties();
    }
    get => _properties;
  }

  private VBoxContainer Items;
  private Array ItemNodes;

  private string NodeName(string name) => $"node-{name}";

  public override void _Ready() {
    Items = GetNode<VBoxContainer>("%items");
    UpdateProperties();
  }

  private void CreateProperties() {
    if (PropertyItem == null || Properties == null) {
      return;
    }
    
    foreach (var pair in Properties) {
      if (Items.GetNodeOrNull(NodeName(pair.Key)) != null) {
        continue;
      }

      var item = (PropertyItem)PropertyItem.Instance();
      item.Name = NodeName(pair.Key);
      item.key = pair.Key;
      Items.AddChild(item);
    }
  }

  private void UpdateProperties() {
    if (Properties == null) {
      return;
    }

    ItemNodes = Items.GetChildren();
    foreach (PropertyItem pitem in ItemNodes) {
      var _k = pitem.key;
      pitem.value = Properties[_k];
    }
  }
}
