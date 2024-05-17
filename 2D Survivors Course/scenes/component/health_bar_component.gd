extends ProgressBar
class_name HealthBarComponent

@export var health_component: HealthComponent


func _ready():
	assert(health_component != null)
	
	health_component.health_changed.connect(on_health_changed)
	update_health_display()
 
 
func on_health_changed():
	update_health_display()
 
 
func update_health_display():
	value = health_component.get_health_percent()


