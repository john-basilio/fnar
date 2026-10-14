extends Control;


@onready var bar = $ProgressBar;
@export var next_scene: String;
var progress: Array[float] = [];

func _ready() -> void:
	# Request to load engine once ready
	ResourceLoader.load_threaded_request(next_scene,"",true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var status = ResourceLoader.load_threaded_get_status(next_scene, progress);
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var percent = progress[0] * 100;
			bar.value = percent;
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(next_scene);
			get_tree().change_scene_to_packed(scene);
