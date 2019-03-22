using Godot;
using System;

public class ClickableArea2D : Area2D
{
    private Boolean hovering = false;
    private Boolean clicked = false;
    private Boolean locked = false;

    private Int16 toggled = 0;
    private Int16 lockToggle = 0;
    private Int16 menuToggle = 0;

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        this.SetProcess(true);
    }

  // Called every frame. 'delta' is the elapsed time since the previous frame.
  public override void _Process(float delta)
    {
    if (hovering)
    {
        //if locked let the parent node know
        if (locked)
        {
            this.GetParent().Set("cursorState", "locked");;
        }
        //if user pressing middle button lock item, 3 is middle mouse button
        if (Input.IsMouseButtonPressed(3))
        { 
            if (lockToggle < 1)
            {
                if (locked)
                {
                    locked = false;
                    //tell parent ot set cursor state to hovering
                    this.GetParent().Set("cursorState", "hovering");
                    GD.Print("unlocked");
                }
                else
                {
                    locked = true;
                    //tell parent to set cursor state to locked
                    this.GetParent().Set("cursorState", "locked");
                    GD.Print("locked");
                }
                lockToggle += 1;
            }
        }//end mouse middle click
        else
        {
            lockToggle = 0;
        }
    }//end hovering

    if (hovering ||  clicked && !locked)
    {
        if (Input.IsMouseButtonPressed(1))
        {
            if (toggled < 1)
            {
                if (clicked)
                    clicked = false;
                else
                    clicked = true;
                toggled += 1;
            }
            else
            {
                toggled = 0;
            }
        }//end left click mouse

        if (Input.IsActionJustPressed("edit") && !locked)
        {
            if (menuToggle < 1)
            {
                //if already open, close
                if (this.GetNode("AttackerMenu").Get("visible").Equals(true))
                {
					this.GetNode("AttackerMenu").Set("visible", false);
					this.GetNode("Attacker/Area2D").Set("visible", false);
					this.GetNode("Attacker/Area2D2").Set("visible", false);
					this.GetNode("Attacker/Area2D3").Set("visible", false);
					this.GetNode("Attacker/Area2D4").Set("visible", false);
					this.GetNode("AttackerMenu").Set("position", new Vector2(30000,30000));
					//set root state to placing
					this.GetNode("/root/Main").Set("state", "placing");
					PlacingButton temp = (PlacingButton)this.GetNode("/root/Main/Camera2D/StatesArea/StatesHBox/PlacingButton");
                    temp._on_PlacingButton_pressed();
                }
                else
                {
                    this.GetNode("AttackerMenu").Set("position", new Vector2(50,-100));
                    this.GetNode("AttackerMenu").Set("visible", true);
                    this.GetNode("AttackerMenu/Area2D").Set("visible", true);
                    this.GetNode("AttackerMenu/Area2D2").Set("visible", true);
                    this.GetNode("AttackerMenu/Area2D3").Set("visible", true);
                    this.GetNode("AttackerMenu/Area2D4").Set("visible", true);
                    //set root state to editing
                    this.GetNode("/root/Main").Set("editorState", "editing");
                    EditingButton eb =  (EditingButton)this.GetNode("/root/Main/Camera2D/StatesArea/StatesHBox/EditingButton");
                    eb._on_EditingButton_pressed();
                }

            }//end MenuToggle <1
            menuToggle += 1;
        }//end edit and !locked
        else
        {
            menuToggle = 0;
        }

    }//end hoverings with click
      
  }
}
