extends Control

@onready var money_ui_element = $Market/VBoxContainer/PanelContainer/Right/Money_Container/Money

func show_page(page_name):
	for child in get_children():
		child.visible = false
	get_node(page_name).visible = true

func _on_button_pressed() -> void:
	show_page("Market")

func generate_item() -> void:
	var item = load("res://scenes/item_ui.tscn")
	var item_scene = item.instantiate()
	item_scene.set_name("item UI")
	$Market/VBoxContainer/Sections/Centre/MarginContainer/ScrollContainer/GridContainer.add_child(item_scene)
	
func _ready() -> void:
	for n in 15:
		generate_item()
	
func _process(delta: float) -> void:
	money_ui_element.text = "$" + str(Global.money)
