extends Area2D
signal hit
@export var speed = 400
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Velocidade inicia do veter 2D é zero
	
	# Definindo os if de movimentação do personagem
	if Input.is_action_pressed("mover_direita"):
		velocity.x += 1
	if Input.is_action_pressed("mover_esquerda"):
		velocity.x = -1
	if Input.is_action_pressed("mover_cima"):
		velocity.y += -1
	if Input.is_action_pressed("mover_baixo"):
		velocity.y += 1
		
		# Esse If Normaliza a velocidade nas diagonais
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("Walk")	
	else:
		$AnimatedSprite2D.stop()	
	
	# Adicionando um Limitador de area 
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)	
	
	# Adicionando flip das animações de acordo com o lado
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "Up"
		$AnimatedSprite2D.flip_v = velocity.y >0

# sinal que o jogador emite ao ser atingido 
func _on_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disable", true)
	
#função parada reiniciar o jogador quando reiniciar o jogo
func start():
	position = Vector2(100, 100)
	show()
	$CollisionShape2D.disabled = false
