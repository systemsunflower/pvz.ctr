extends Node2D
# Star collectible object (可收集的星星对象)

# Called when a body enters the star's area (当物体进入星星区域时调用)
func _on_area_2d_body_entered(body: Node2D) -> void:
	AutoLoad.add_start(1)
	$Area2D.queue_free()
	$Sprite2D.queue_free()
	$AudioStreamPlayer2D.play()


# Called when the collection sound finishes playing (当收集音效播放完成时调用)
func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
