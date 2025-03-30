extends RigidBody2D
# Zombie head physics object (僵尸头部物理对象)

const TRIGGER_DISTANCE = 500  # Trigger distance in pixels (触发距离（像素）)
var player  # Reference to player node (玩家节点引用)

# Called when the node enters the scene tree (当节点进入场景树时调用)
func _ready():
	# Get viewport boundaries (获取视口边界)
	var viewport_rect = get_viewport().get_visible_rect()
	# Set detection range to screen plus extra distance (设置检测范围为屏幕加上额外距离)
	var expanded_rect = viewport_rect.grow(TRIGGER_DISTANCE)
	$VisibleOnScreenNotifier2D.rect = Rect2(expanded_rect.position, expanded_rect.size)
	
	# Get current scene and player node (获取当前场景和player节点)
	await get_tree().create_timer(0.1).timeout
	var current_scene = get_tree().current_scene
	player = current_scene.get_node("player")

# Triggered when the object leaves the expanded screen area (当物体离开扩展区域时触发)
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	player.animation_player.play("lose")  # Play lose animation (播放失败动画)
