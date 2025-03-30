extends CanvasLayer
# Main autoload script that manages game state (主要的自动加载脚本，用于管理游戏状态)

func _ready():
	# Set CanvasLayer layer level to ensure it's on top (设置 CanvasLayer 的层级，确保在最上层)
	layer = 128
	
	# Ensure menu and victory screen are on top layer (确保菜单和胜利界面在最上层)
	$menu.mouse_filter = Control.MOUSE_FILTER_STOP
	$win.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Check system language and load corresponding language file (检查系统语言并加载相应的语言文件)
	var sys_lang: = OS.get_locale_language().to_lower().substr(0, 2)
	if sys_lang == ("zh"):
		TranslationServer.set_locale(sys_lang)
	add_start(0)

	# Initialize victory screen as hidden (初始化胜利界面为隐藏)
	$win.visible = false
	

# Function to add stars to the count (增加星星数量的函数)
func add_start (number:int):
	stars += number
	srarts.text = tr("srarts") + str(stars)


# Reference to the menu control node (菜单控制节点的引用)
@onready var control: Control = $menu/Control
# Reference to the stars count label (星星数量显示标签的引用)
@onready var srarts: Label = $srarts
# Current collected stars count (当前收集的星星数量)
var stars :int = 0
# Level number (关卡编号)
var lever : int = 1
# Maximum level number (最大关卡数)
const max_lever = 4
# Function to handle victory condition (处理胜利条件的函数)
func win():
	if not $win.visible:  # Add check to prevent repeated triggering (添加检查，防止重复触发)
		$win.visible = true
		# When passing the highest level, show "Coming Soon" and reset level (当通过最高关时，显示"敬请期待"并重置关卡)
		if lever == max_lever:
			$win/quite.text = tr("staytuned")
			lever = 0


# Play button sound effect (播放按钮音效)
func _button_sound() -> void:
	$buttonclick.playing = true


# Response function for exit game button (退出游戏按钮的响应函数)
func _on_menu_3_button_up() -> void:
	$win.visible = false
	get_tree().quit()

# Response function for restart button (重新开始按钮的响应函数)
func _on_restart_button_up() -> void:
	$win.visible = false
	get_tree().reload_current_scene()


# Response function for menu button (菜单按钮的响应函数)
func _on_menu_button_up() -> void:
	if control.visible == false:
		# Ensure menu is on top when displaying it (显示菜单时确保它在最上层)
		control.show()
		control.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		control.hide()


# Response function for continue game button (继续游戏按钮的响应函数)
func _on_quite_button_up() -> void:
	# Hide victory screen and load next level (隐藏胜利界面并加载下一关)
	$win.visible = false
	if lever < max_lever:  # Add check to prevent exceeding maximum level number (添加判断，防止超出最大关卡数)
		lever += 1
		get_tree().change_scene_to_file("res://Levels/" + str(lever) + ".tscn")
