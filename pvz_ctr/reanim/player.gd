extends Node2D
# Player character controller (玩家角色控制器)

@onready var animation_player: AnimationPlayer = $AnimationPlayer  # Reference to animation player (动画播放器引用)

# Called when game is over (游戏结束时调用)
func game_over():
	get_tree().reload_current_scene()  # Reload the current scene (重新加载当前场景)

# Called when a body enters the player's area (当物体进入玩家区域时调用)
func _on_area_2d_body_entered(body: Node2D) -> void:
	#AutoLoad.win.visible = true
	body.queue_free()  # Remove the colliding body (移除碰撞的物体)
	animation_player.play("win")  # Play win animation (播放胜利动画)
	AutoLoad.win()  # Call win function in AutoLoad (调用AutoLoad中的win函数)
