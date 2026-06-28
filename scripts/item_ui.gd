extends Control

@onready var item = $item
@onready var panel_container = $PanelContainer2
@onready var buy_button = $PanelContainer2/GridContainer/VBoxContainer/MarginContainer/Buy_Button

func _ready() -> void:
	item.initialize_item()
	_rarity_ui(item.rarity)	

func _rarity_ui(item_rarity) -> void:
	if item_rarity == "common":
		panel_container.self_modulate = Color8(245,255,255)
	elif item_rarity == "uncommon":
		panel_container.self_modulate = Color8(20,235,30)


func _on_buy_button_pressed() -> void:
	if Global.money >= item.price:
		Global.money -= item.price
		print("bought: ", item.type)
		queue_free()
	else:
		print("not enough money!")
	



func _on_buy_button_mouse_entered() -> void:
	item.button_enter()


func _on_buy_button_mouse_exited() -> void:
	item.button_exit()
