using Godot;
using System;

public class PlacingButton : CheckButton
{
    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.



    public void _on_PlacingButton_pressed()
    {
        //when this is pressed set other states off
        this.SetPressed(true);
        Button temp = (Button)this.GetParent().GetNode("EditingButton");
        temp.SetPressed(false);
        //self.get_parent().get_node("EditingButton").set_pressed(false);

        this.GetParent().GetParent().GetParent().Set("editorState", "placing");
        //self.get_parent().get_parent().get_parent().get_parent().editorState = "placing"
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
