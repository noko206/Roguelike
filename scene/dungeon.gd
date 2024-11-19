extends Node3D

@onready var SophiaSkin = $SophiaSkin

const FIELD_WIDTH = 35
const FIELD_HEIGHT = 35
const ROOM_SIZE = 9

var field = []
var room_centers = []

func _ready() -> void:
	randomize()
	
	field = create_dungeon()
	
	const glass_field = "./glass_field.tscn"
	const loaded_glass_field = preload(glass_field)
	
	const glass_wall = "./glass_wall.tscn"
	const loaded_glass_wall = preload(glass_wall)
	
	for x in range(FIELD_WIDTH):
		for y in range(FIELD_HEIGHT):
			var current_x = -FIELD_WIDTH + x * 2 + 1
			var current_z = -FIELD_HEIGHT + y * 2 + 1
			var instance = loaded_glass_field.instantiate()
			instance.position = Vector3(current_x, 0.0, current_z)
			add_child(instance)
			if (!field[x][y]):
				instance = loaded_glass_wall.instantiate()
				instance.position = Vector3(current_x, 0.0, current_z)
				add_child(instance)

	var rand_x = randi() % 2
	var rand_y = randi() % 2
	var room_center = room_centers[rand_x][rand_y];
	var position_x = (room_center.x - FIELD_WIDTH / 2) * 2
	var position_y = (room_center.y - FIELD_HEIGHT / 2) * 2
	SophiaSkin.global_position = Vector3(position_x, 0.0, position_y)
	SophiaSkin.current_position = Vector3(position_x, 0.0, position_y)
	SophiaSkin.target_position = Vector3(position_x, 0.0, position_y)
	SophiaSkin.camera.position = Vector3(position_x, 0.0, position_y)

func _process(delta: float) -> void:
	pass

func create_dungeon():
	var field = []
	for x in range(FIELD_WIDTH):
		field.append([])
		for y in range(FIELD_HEIGHT):
			field[x].append(false)

	for x in range(2):
		room_centers.append([])
		for y in range(2):
			var rand_x = randi() % (FIELD_WIDTH / 2 - 2 - ROOM_SIZE + 1)
			var rand_y = randi() % (FIELD_HEIGHT / 2 - 2 - ROOM_SIZE + 1)
			room_centers[x].append(Vector2(rand_x + x * FIELD_WIDTH / 2 + ROOM_SIZE / 2 + 1 + x, rand_y + y * FIELD_HEIGHT / 2 + ROOM_SIZE / 2 + 1 + y))
			print(room_centers[x][y].x, ' ', room_centers[x][y].y)

	for i in range(2):
		for j in range(2):
			for x in range(ROOM_SIZE):
				for y in range(ROOM_SIZE):
					var room_x = room_centers[i][j].x + x - ROOM_SIZE / 2
					var room_y = room_centers[i][j].y + y - ROOM_SIZE / 2
					field[room_x][room_y] = true;
	
	# デバッグ用
	#for x in range(FIELD_WIDTH):
		#field[x][FIELD_HEIGHT / 2] = true
	#for y in range(FIELD_HEIGHT):
		#field[FIELD_WIDTH / 2][y] = true
	
	# 左上
	var v1 = room_centers[0][0]
	var x = v1.x
	while x < FIELD_WIDTH / 2:
		field[x][v1.y] = true
		x += 1
	var y = v1.y
	var v2 = room_centers[1][0]
	while y != v2.y:
		field[x][y] = true
		if y < v2.y:
			y += 1
		else:
			y -= 1
	while x <= v2.x:
		field[x][v2.y] = true
		x += 1
	# 右上
	y = v2.y
	while y < FIELD_HEIGHT / 2:
		field[v2.x][y] = true
		y += 1
	x = v2.x
	var v3 = room_centers[1][1]
	while x != v3.x:
		field[x][y] = true
		if x < v3.x:
			x += 1
		else:
			x -= 1
	while y <= v3.y:
		field[v3.x][y] = true
		y += 1
	# 右下
	x = v3.x
	while x > FIELD_WIDTH / 2:
		field[x][v3.y] = true
		x -= 1
	y = v3.y
	var v4 = room_centers[0][1]
	while y != v4.y:
		field[x][y] = true
		if y < v4.y:
			y += 1
		else:
			y -= 1
	while x >= v4.x:
		field[x][v4.y] = true
		x -= 1
	# 右上
	y = v4.y
	while y > FIELD_HEIGHT / 2:
		field[v4.x][y] = true
		y -= 1
	x = v4.x
	while x != v1.x:
		field[x][y] = true
		if x < v1.x:
			x += 1
		else:
			x -= 1
	while y >= v1.y:
		field[v1.x][y] = true
		y -= 1
	
	return field
