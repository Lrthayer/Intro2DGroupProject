extends Control

# Get Dropdown Node
export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

# Start
func _ready():
	# Setup connection
	dropdown.connect("item_selected", self, "on_item_selected")

	# Select Initially Selected Item 
	select_item(1)

# Adding Items to Dropdown
func add_item():
	dropdown.add_item("newLevel")

func save_item(image):
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	texture.set_size_override(Vector2(215,190))
	dropdown.add_icon_item(texture,"",7)
		
	#dropdown.add_icon_item(load("res://icon.png"),"",7)

# Select Item
func select_item(id):
	dropdown.select(id)

# Remove one item
func remove_item(id):
	dropdown.remove_item(id)

# Disable one item
func disable_item(id):
	# Disable item
	dropdown.set_item_disabled(id, true)
	
	# Rename item
	dropdown.set_item_text(id, "Disabled!")

# Removes all items from dropdown
func clear_all():
	dropdown.clear()

# On item selected
func on_item_selected(id):
	pass
	# print(str(dropdown.get_item_text(id)))