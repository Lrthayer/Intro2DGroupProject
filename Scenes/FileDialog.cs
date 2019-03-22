using Godot;
using System;

public class FileDialog : Godot.FileDialog
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        this.SetProcess(true);
        this.Connect("confirmed", this, nameof(test));
        this.Connect("file_selected", this, nameof(_on_FileDialog_file_selected));
        GD.Print("test");
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {

    }

    public void test()
    {
        GD.Print("test");
    }
    public void _on_FileDialog_file_selected(String path)
    {
        //get path of file selected and try to make it a texture.
        ImageTexture tex = new ImageTexture();
        Image img = new Image();
        img.Load(path);
        tex.CreateFromImage(img);

        //create a sprite with our level editor tools for the texture
        Area2D clickArea = new ClickableArea2D();
        Sprite newSprite = new Sprite();
        clickArea.AddChild(newSprite);

        //clickArea.Connect("mouse_entered", this.GetParent(), "on");

        this.GetParent().AddChild(clickArea);
        //this.AddChild(newSprite);
        newSprite.SetTexture(tex);
        newSprite.GlobalPosition = this.GetGlobalMousePosition();
    }
}
