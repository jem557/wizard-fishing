class_name EntityUtils
extends RefCounted

static func Initalize_Components(entity) -> void:
	if "movement_component" in entity and entity.movement_component != null:
		entity.movement_component.initialize(entity)
	if "behavior_component" in entity and entity.behavior_component != null:
		entity.behavior_component.initialize(entity)
	if "attachment_component" in entity and entity.attachment_component != null:
		entity.attachment_component.initialize(entity)
	if "animation_component" in entity and entity.animation_component != null:
		entity.animation_component.initialize(entity)
	if "detection_component" in entity and entity.detection_component != null:
		if "attachment_component" in entity and entity.attachment_component != null:
			entity.detection_component.AP = entity.attachment_component.get_children()
			entity.detection_component.hook_area_entered.connect(entity.attachment_component._attach)
		entity.detection_component.initialize(entity)
		if "behavior_component" in entity and entity.behavior_component != null:
			entity.behavior_component.rays = entity.detection_component.rays
			entity.behavior_component.areas = entity.detection_component.areas
	if "health_component" in entity and entity.health_component != null:
		entity.health_component.initialize(entity)
