extends TextureRect
# Background texture controller (背景纹理控制器)

func _ready():
	# Set anchors and size to fill the screen (设置锚点和大小以铺满屏幕)
	anchor_right = 1.0
	anchor_bottom = 1.0
	offset_right = 0
	offset_bottom = 0
	
	# Set stretch mode to keep aspect ratio and cover (设置拉伸模式为保持纵横比并覆盖)
	#stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
