extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var creature: Creature = $Creature
@onready var player: Player = $"../Player"


var triggered:bool = false
func _on_body_entered(body: Node3D) -> void:
	if triggered: return
	if !body is Player: return
	GameManager.pause()
	await move_to_player()
	await animation_player.animation_finished
	await get_tree().create_timer(.5).timeout
	animation_player.play("cutscene_f_part2")
	await animation_player.animation_finished
	GameManager.end()


func move_to_player()->void:
	var tween:Tween = get_tree().create_tween()
	var time:float = .5
	tween.set_parallel(true)
	tween.tween_property(creature,"global_position",player.global_position,time)
	creature.play("run_cycle")
	tween.tween_method(player.view_camera.look_at,(player.global_position+(player.global_transform.basis * Vector3.FORWARD)),creature.global_position,.25)
	tween.play()
	#player.view_camera.look_at(creature.global_position)
	await tween.finished
	animation_player.play("cutscene_f_part1")
