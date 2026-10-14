extends Label

const main: PackedScene = preload("res://main_menu.tscn");
@onready var timer = get_node("../ftimer");
@onready var anim = get_node("../animation");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the function and trigger once the timer has "ticked".
	timer.connect("timeout", text_timeout);
	anim.play("fade");
	await anim.animation_finished;
	timer.start();
	await timer.timeout;
	
func text_timeout() -> void:
	anim.play_backwards("fade");
	await anim.animation_finished; 
	# Since the script is shared by multiple Label(s), check first
	# if still in the tree so whoever is latter won't reference to tree
	# that has alrady exited.
	if not is_inside_tree():
		return;
	get_tree().change_scene_to_packed(main);

func _input(event: InputEvent) -> void:
	# Call skip text early.
	if event.is_action_pressed("space"): 
		text_timeout()
