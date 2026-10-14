extends Control;

@onready var play = $play;
@onready var exit = $exit;
@onready var arrow = $arrow;

func _ready() -> void:

	# Bind hover signals from labels
	play.mouse_entered.connect(handle_hover.bind(play));
	exit.mouse_entered.connect(handle_hover.bind(exit));
	
	# Bind click signals
	play.gui_input.connect(handle_click.bind(play));
	exit.gui_input.connect(handle_click.bind(exit));

func handle_hover(item: Label) -> void:
	arrow.global_position.y = item.global_position.y;

func handle_click(event: InputEvent, item: Label) -> void:
	if event.is_pressed() :
		match item.name:
			"play":
				get_tree().change_scene_to_file("res://splash.tscn");
			"exit":
				get_tree().quit();
