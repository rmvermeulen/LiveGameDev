# press ctrl+r to attach the script
extends Camera

func _init(): pass

func _ready(): pass

func _process(delta: float):
	rotation.y = wrapf(rotation.y + delta, -PI, PI)
