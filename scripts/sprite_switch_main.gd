extends CanvasLayer;

@onready var sprites: Array[Sprite2D] = [
	$rene,
	$saintrene
];

func _ready() -> void:
	# Hide all alternate sprites except the first one.
	for sprite in sprites:
		sprite.visible = false;

	sprites[0].visible = true;

	random_glitch_loop();

func random_glitch_loop() -> void:
	while true:
		# Random trigger timer
		await get_tree().create_timer(randf_range(.5, 3.0)).timeout

		# Choose a random sprite.
		var chosen: Sprite2D = sprites.pick_random()

		# Hide the current sprite and show the chosen one.
		for sprite in sprites:
			sprite.visible = false

		chosen.visible = true

		# Keep the glitch visible briefly.
		await get_tree().create_timer(0.08).timeout

		# Restore the original sprite.
		for sprite in sprites:
			sprite.visible = false

		sprites[0].visible = true
