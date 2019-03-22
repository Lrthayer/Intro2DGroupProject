using Godot;
using System;

public class EditingButton : CheckButton
{

    public void _on_EditingButton_pressed()
    {
        //#when this is pressed set other states off
        this.SetPressed(true);
        PlacingButton pb = (PlacingButton)this.GetParent().GetNode("PlacingButton");
        pb.SetPressed(false);
        this.GetParent().GetParent().GetParent().GetParent().Set("editorState", "editing");
    }
}
