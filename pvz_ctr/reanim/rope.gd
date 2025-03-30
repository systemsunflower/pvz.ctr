extends RigidBody2D
# Rope segment physics object (绳子段物理对象)

var is_mouse_pressed: bool = false  # Flag to track if mouse is pressed (鼠标按下状态标志)
var mouse_history: Array[Vector2] = []  # Array to store mouse position history (鼠标位置历史数组)
const HISTORY_FRAMES = 5  # Number of frames to keep in history (历史记录保留的帧数)
var previous_mouse_pos: Vector2  # Previous mouse position (前一个鼠标位置)

# Called when an input event occurs (当输入事件发生时调用)
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			is_mouse_pressed = true  # Set mouse pressed flag (设置鼠标按下标志)
			previous_mouse_pos = get_global_mouse_position()  # Store initial position (存储初始位置)
		else:
			is_mouse_pressed = false  # Clear mouse pressed flag (清除鼠标按下标志)
	elif event is InputEventMouseMotion and is_mouse_pressed:
		var current_mouse_pos = get_global_mouse_position()  # Get current mouse position (获取当前鼠标位置)
		# Perform ray casting (执行射线检测)
		var space_state = get_world_2d().direct_space_state
		var params = PhysicsRayQueryParameters2D.create(previous_mouse_pos, current_mouse_pos)
		params.collision_mask = 1  # Set target collision layer, adjust as needed (设置目标碰撞层，根据实际情况调整)
		var result = space_state.intersect_ray(params)
		if result:
			# Check if the hit collider is the current node (e.g., rope segment) (判断击中的碰撞体是否为当前节点（例如绳子段）)
			if result.collider == self:
				queue_free()  # Remove this rope segment (移除这个绳子段)
		# Update previous position (更新前一个位置)
		previous_mouse_pos = current_mouse_pos
