using System;
using Godot;
using godotcsharpgame.Script.Util;
using Array = Godot.Collections.Array;

public class Slot : TextureRect {
  [Signal]
  public delegate void PickItem(Slot slot);

  [Signal]
  public delegate void UseItem(Slot slot);

  [Export] public Vector2 PositionS { set; get; }

  private TextureButton ItemImage;
  private Label Amount;
  private NinePatchRect ItemEffectBorder;

  private bool IsHover;

  public override void _Ready() {
    ItemImage = GetNode<TextureButton>("%item");
    ItemImage.Connect("mouse_entered", this, "OnHover", new Array() {true});
    ItemImage.Connect("mouse_exited", this, "OnHover", new Array() {false});

    Amount = GetNode<Label>("%amount");
    ItemEffectBorder = GetNode<NinePatchRect>("%effect");

    Initialize();
  }

  private void Initialize() {
    Amount.Visible = false;
    Amount.Text = "0";
  }

  public void OnHover(bool hover) {
    IsHover = hover;
  }

  public override void _PhysicsProcess(float delta) {
    if (IsHover == false) return;
    if (Input.IsActionJustPressed("ui_lmb")) {
      EmitSignal("PickItem", this);
      // RectGlobalPosition = GetGlobalMousePosition() - (RectSize * 0.5f);
      // L.t($"mouse key down {GetLocalMousePosition()}");
    }
    else if (Input.IsActionJustPressed("ui_rmb")) {
      EmitSignal("UseItem", this);
    }
  }

  public void SetItemImage(string itemId) {
    if (ItemImage == null) {
      return;
    }

    Texture res = null;
    if (String.IsNullOrEmpty(itemId)) {
      return;
    }

    res = ResourceLoader.Load<Texture>($"res://Assets/Icons/Items/{itemId}.png");
    ItemImage.TextureNormal = res;
  }

  public void SetAmount(int amount) {
    if (Amount == null) {
      return;
    }

    var s = $"{amount}";
    Amount.Visible = amount > 0;
    if (amount > 99) {
      s = $"{amount}+";
    }

    Amount.Text = s;
  }

  public void SetItemEffectBorder(string effect) {
    if (ItemEffectBorder == null) {
      return;
    }

    var tex = ResourceLoader.Load<Texture>($"res://Assets/UI/root/slot/{effect}.png");
    ItemEffectBorder.Texture = tex;
  }
}
