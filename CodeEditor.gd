extends PanelContainer

export (String) var active_script
export (GDScript) var initial_script: GDScript

onready var editor: TextEdit = find_node	("TextEdit")
onready var run_button: Button = find_node("RunButton")

func _ready():
	_create_run_shortcut()
	run_button.connect("pressed", self, "_on_run_button_pressed")
	
	_load_initial_script()
	
func _input(event: InputEvent):
	if (event is InputEventKey
	&& event.pressed
	&& event.alt):
		match event.scancode:
			KEY_LEFT: editor.cursor_set_line(
				editor.cursor_get_line() - 1)
			KEY_RIGHT: editor.cursor_set_line(
				editor.cursor_get_line() + 1)
	
func _on_run_button_pressed():
	var target: Camera = get_viewport().get_camera()
	var script := GDScript.new()
	script.source_code = PoolStringArray([
		# todo: insert setup code
		editor.text,
	]).join("\n")
	script.reload(true)
	target.set_script(script)
	target.request_ready()
	
func _create_run_shortcut():
	var sc := ShortCut.new()
	var ev := InputEventKey.new()
	ev.scancode = KEY_R
	ev.control = true
	sc.shortcut = ev
	run_button.shortcut = sc
	run_button.shortcut_in_tooltip = true
	
func _load_initial_script():
	if not initial_script:
		return
	prints(initial_script)
	editor.text = initial_script.source_code
	
# end
