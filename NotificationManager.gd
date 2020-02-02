extends Node2D

onready var n = $BreakNotificationText

var notifying_repair = 0
var notifying_upgrade = 0
var notifying_break = 0

export var notification_offset = 80

func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventKey and event.is_pressed():
        if event.get_scancode() == KEY_J:
            notify_break("joku hassu osaasdsadasdsad", 960 / 2)
        if event.get_scancode() == KEY_K:
            notify_repair("toinen hassu osanen", 960 / 2)
        if event.get_scancode() == KEY_L:
            notify_upgrade(960 / 2)
            
func _get_y_offset():
    var y = 0
    if notifying_repair:
        y -= 1
    if notifying_upgrade:
        y -= 1
    if notifying_break:
        y -= 1
    return y * notification_offset

func notify_repair(part, y):
    if notifying_repair: 
        return
    var y_mod = y + _get_y_offset()
    notifying_repair += 1
    n = $RepairNotificationText
    _notify("%s repaired!" % part, y_mod, $RepairTween)
    
func notify_upgrade(y):
    if notifying_upgrade:
        return
    var y_mod = y + _get_y_offset()
    notifying_upgrade += 1
    n = $UpgradeNotificationText
    _notify("Ship upgraded!", y_mod, $UpgradeTween)
    
func notify_break(part, y):
    if notifying_break:
        return
    var y_mod = y + _get_y_offset()
    notifying_break += 1
    n = $BreakNotificationText
    _notify("%s broke down!" % part, y_mod, $BreakTween)
    
func _notify(text, y, t):
    n.text = text
    n.rect_position.y = y
    n.rect_rotation = 0
    n.visible = true
    var tween_pos = n.rect_position
    t.interpolate_property(n, "rect_rotation",
        0.0, -10, 0.1,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    t.interpolate_property(n, "rect_scale",
        Vector2(1.0, 1.0), Vector2(1.5, 1.5), 0.1,
        Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
        
    t.start()

func _on_BreakTween_tween_all_completed():
    if notifying_break == 1:
        notifying_break += 1
        $BreakTimer.start()
    else:
        notifying_break = 0

func _on_RepairTween_tween_all_completed():
    if notifying_repair == 1:
        notifying_repair += 1
        $RepairTimer.start()
    else:
        notifying_repair  = 0

func _on_UpgradeTween_tween_all_completed():
    if notifying_upgrade == 1:
        notifying_upgrade += 1
        $UpgradeTimer.start()
    else:
        notifying_upgrade  = 0


func _on_BreakTimer_timeout():
    var tween_pos = $BreakNotificationText.rect_position
    tween_pos.y += 1500
    $BreakTween.interpolate_property($BreakNotificationText, "rect_position",
    $BreakNotificationText.rect_position, tween_pos, 0.3,
    Tween.TRANS_CUBIC, Tween.EASE_IN)
    $BreakTween.start()


func _on_RepairTimer_timeout():
    var tween_pos = $RepairNotificationText.rect_position
    tween_pos.y += 1500
    $RepairTween.interpolate_property($RepairNotificationText, "rect_position",
    $RepairNotificationText.rect_position, tween_pos, 0.3,
    Tween.TRANS_CUBIC, Tween.EASE_IN)
    $RepairTween.start()


func _on_UpgradeTimer_timeout():
    var tween_pos = $UpgradeNotificationText.rect_position
    tween_pos.y += 1500
    $UpgradeTween.interpolate_property($UpgradeNotificationText, "rect_position",
    $UpgradeNotificationText.rect_position, tween_pos, 0.3,
    Tween.TRANS_CUBIC, Tween.EASE_IN)
    $UpgradeTween.start()

