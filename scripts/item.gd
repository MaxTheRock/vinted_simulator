extends Node2D

var colours = ["white","yellow", "red", "green", "blue", "black", "purple", "pink", "cyan", "orange"]
var items = ["t_shirt","socks","trousers","shorts"]
var rng = RandomNumberGenerator.new()
var number = 0
var color = ""
var shippingTime = 0
var condition = "Good"
var condition_price_mult = 1
var price = 0
var type = ""
var last_frame: int = 0
var chosen_frame: int = 0

@onready var tshirt_sprite: AnimatedSprite2D = $TextureButton/t_shirt
@onready var socks_sprite: AnimatedSprite2D = $TextureButton/socks
@onready var trouser_sprite: AnimatedSprite2D = $TextureButton/trousers
@onready var shorts_sprite: AnimatedSprite2D = $TextureButton/shorts

func _ready() -> void:
	rng.randomize()
	type = items[rng.randi_range(0, items.size() - 1)]
	generate_parameters(type)
	set_item_type(type)
	if type == "t_shirt":
		switch_shirt(tshirt_sprite, number);
	elif type == "socks":
		switch_shirt(socks_sprite, number);

func set_item_type(item_type: String) -> void:
	for child in get_tree().get_nodes_in_group("clothes"):
		if child.owner == self:
			child.visible = (child.name == item_type)
	
func _on_texture_button_mouse_entered():
	$FrameTimer.start()

func _on_texture_button_mouse_exited():
	$FrameTimer.stop()

func _on_frame_timer_timeout():
	for child in get_tree().get_nodes_in_group("clothes"):
		if child.visible and child is AnimatedSprite2D and child.owner == self:
			var max_frames = child.sprite_frames.get_frame_count("default")
			var new_frame = rng.randi_range(0, max_frames - 1)
			while new_frame == child.frame and max_frames > 1:
				new_frame = rng.randi_range(0, max_frames - 1)
			child.frame = new_frame
			print("Frame:", child.frame)

func generate_parameters(type):
	if type == "t_shirt":
		number = rng.randi_range(0, 9)
		color = colours[number]
		shippingTime = rng.randi_range(1, 5.0)
		condition = "Good"
		if condition == "Good":
			condition_price_mult = 1
		price = snapped(2.5 * condition_price_mult * rng.randf_range(0.8,1.2),0.01)
		
	elif type == "socks":
		number = rng.randi_range(0, 9)
		color = colours[number]
		shippingTime = rng.randi_range(1, 5.0)
		condition = "Good"
		if condition == "Good":
			condition_price_mult = 1
		price = snapped(1.5 * condition_price_mult * rng.randf_range(0.8,1.2),0.01)
	
	elif type == "trousers":
		number = rng.randi_range(0, 9)
		color = colours[number]
		shippingTime = rng.randi_range(1, 5.0)
		condition = "Good"
		if condition == "Good":
			condition_price_mult = 1
		price = snapped(4.5 * condition_price_mult * rng.randf_range(0.8,1.2),0.01)
		
	elif type == "shorts":
		number = rng.randi_range(0, 9)
		color = colours[number]
		shippingTime = rng.randi_range(1, 5.0)
		condition = "Good"
		if condition == "Good":
			condition_price_mult = 1
		price = snapped(3 * condition_price_mult * rng.randf_range(0.8,1.2),0.01)
		
		
		
func switch_shirt(sprite, num):
	set_node_palette(sprite, num)

func set_node_palette(target_sprite: AnimatedSprite2D, num):
	print(target_sprite.name, " material: ", target_sprite.material, " is_shader: ", target_sprite.material is ShaderMaterial)
	if target_sprite and target_sprite.material is ShaderMaterial:
		target_sprite.set_instance_shader_parameter("palette_index", num)
