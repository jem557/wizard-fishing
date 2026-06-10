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
			if not entity.attachment_component.attach_points.is_empty():
				entity.detection_component.mouth_canonical = entity.attachment_component.attach_points[0].pos
			entity.detection_component.hook_area_entered.connect(entity.attachment_component._attach)
		entity.detection_component.initialize(entity)
		if "behavior_component" in entity and entity.behavior_component != null:
			entity.behavior_component.rays = entity.detection_component.rays
	if "health_component" in entity and entity.health_component != null:
		entity.health_component.initialize(entity)
	if "stamina_component" in entity and entity.stamina_component != null:
		entity.stamina_component.initialize(entity)
	_wire_facing(entity)
	
static func _wire_facing(entity) -> void:
	if not "facing" in entity:
		return	
	if "animation_component" in entity and entity.animation_component != null:
		entity.facing_changed.connect(entity.animation_component._on_facing_changed)
	if "attachment_component" in entity and entity.attachment_component != null:
		entity.facing_changed.connect(entity.attachment_component._on_facing_changed)
	if "detection_component" in entity and entity.detection_component != null:
		entity.facing_changed.connect(entity.detection_component._on_facing_changed)
	entity.facing_changed.emit(entity.facing)
