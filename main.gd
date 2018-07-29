extends Control

# Get Dropdown Node
export (NodePath) var dropdown_path # Select the main node and add path from inspector
onready var dropdown = get_node(dropdown_path)

# Array
var fruit_array = ["Apple", "Orange", "Banana", "Lemon"]


# Start
func _ready():
	# Setup connection
	dropdown.connect("item_selected", self, "on_item_selected")
	
	# Add Items
	# add_items()
	
	# Add Fruit Items
	add_fruit_items()
	
	# Select Initially Selected Item 
	select_item(3)
	
	# Remove item
	remove_item(1)
	
	# Disable item
	disable_item(4)
	
	# Clear All
	# clear_all()

# Adding Items to Dropdown
func add_items():
	dropdown.add_item("Item 1")
	dropdown.add_separator()
	dropdown.add_item("Item 2")
	dropdown.add_item("Item 3")
	dropdown.add_item("Item 4")
	dropdown.add_item("Item 5")

# Adding Fruit Items to Dropdownm
func add_fruit_items():
	for item in fruit_array:
		dropdown.add_item(item)
		
	dropdown.add_icon_item(load("res://icon.png"),"",7)


# Select Item
func select_item(id):
	dropdown.select(id)


# Remove one item
func remove_item(id):
	dropdown.remove_item(id)
	fruit_array.remove(id)


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
	# print(str(dropdown.get_item_text(id)))
	print(fruit_array[id])