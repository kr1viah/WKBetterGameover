extends VBoxContainer
@onready var speedrun_time = %speedrunTime
@onready var char_list = %charList
@onready var upgrade_list = %upgradeList
@onready var item_list = %itemList
@onready var action_list = %actionList
@onready var char_ref = %charRef
@onready var upgrade_ref = %upgradeRef
@onready var item_ref = %itemRef
@onready var speedrun_label = %speedrunLabel
@onready var speedrun_value = %speedrunValue

@onready var coins = %coins
@onready var stars = %stars
@onready var items = %items

func _ready():
	Events.languageChanged.connect(func():
		if not is_instance_valid(self) or is_queued_for_deletion():
			return
		speedrun_label.text = tr("speedrun time") + ":"
	)
	update()

func update():
	for c in get_children():
		if "update" in c:
			c.update()
	
	if Global.options.showSpeedrunTimer:
		speedrun_time.visible = true
		speedrun_label.text = tr("speedrun time") + ":"
		speedrun_value.text = Utils.hms(Global.speedrunTime, 2)
	
	for d in Players.details:
		var node = char_ref.duplicate()
		node.visible = true
		node.texture = Players.charData[d.char].statIcon
		
		char_list.add_child(node)
	
	if Players.challengeMode:
		coins.visible = false
		stars.visible = false
		items.visible = false
	else:
		coins.visible = true
		stars.visible = true
		items.visible = true
	
	Utils.removeChildren(upgrade_list)
	Utils.removeChildren(item_list)
	Utils.removeChildren(action_list)
	for itemName in ShopData.shopItemChoices.keys():
		var item = ShopData.shopItemChoices[itemName]
		if item.has("action"):
			if item.action == true:
				var count = 0
				if item.has("count"):
					count = item.count
				else:
					count = item.value.call()
				if count > 0:
					var node = item_ref.duplicate()
					node.visible = true
					
					node.get_node("label").text = str(count)
					node.get_node("texture").texture = item.icon.call()[0]
					
					action_list.add_child(node)
		else:
			var count = 0
			if item.has("count"):
				count = item.count
			else:
				count = item.value.call()
			if count > 0:
				var node = item_ref.duplicate()
				node.visible = true
				
				node.get_node("label").text = str(count)
				node.get_node("texture").texture = item.icon.call()[0]
				
				item_list.add_child(node)
	
	for upgrade in ShopData.shopUpgradeChoices:
		
		var count = upgrade.value.call()
		if count > 0:
			var node = upgrade_ref.duplicate()
			node.visible = true
			
			node.get_node("label").text = str(count)
			node.get_node("texture").texture = upgrade.icon.call()[0]
			
			upgrade_list.add_child(node)
	
	for d in Players.details:
		var abilityUpgrade = ShopData.abilityChoices[d.char]
		var count = abilityUpgrade.value.call()
		if count > 0:
			var node = upgrade_ref.duplicate()
			node.visible = true
			
			node.get_node("label").text = str(count)
			node.get_node("texture").texture = abilityUpgrade.icon.call()[0]
			
			upgrade_list.add_child(node)
