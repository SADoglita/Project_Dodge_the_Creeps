extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_animations()
	
func randomize_animations():
	var animation_names = $animation_names
	var selected_animations = []

	while selected_animations.size() < 3:
		var random_animation = animation_names[randi() % animation_names.size()]
	
		if !selected_animations.contains(random_animation):
			selected_animations.append(random_animation)

	# Define as animações selecionadas aleatoriamente
	animation = selected_animations[0]
	await get_tree().create_timer(1.0).timeout
	animation = selected_animations[1]
	await get_tree().create_timer(1.0).timeout
	animation = selected_animations[2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
