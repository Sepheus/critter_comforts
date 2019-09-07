import raylib;
import star.entity;
import game.components;
import game.systems;

void main() {
	SetConfigFlags(FLAG_VSYNC_HINT);
	InitWindow(640, 480,"");
	SetTargetFPS(60);
    Camera2D camera;
	auto engine = new Engine();
	auto player = engine.entities.create();
	auto oakRoom = engine.entities.create();
	Entity[3] enemies;
	foreach(ref e; enemies) {
		e = engine.entities.create();
	}
	InitAudioDevice();

	oakRoom.add(new Audio("assets/audio/cafe_bg.ogg"));
	oakRoom.add(new Background("assets/sprites/Room.png"));
	oakRoom.add(new Position(Vector2(0.0f, 0.0f)));

	player.add(new Position(Vector2(448, 448)));
	player.add(new Animation("assets/sprites/Mack5.png", Vector2(0.0f, 0.0f), 5, Vector2(64.0f, 64.0f)));
	player.add(new Controllable());
	player.add(new Velocity());
	enemies[0].add(new Position(Vector2(32, 32)));
	enemies[0].add(new Velocity(24.0f, 0.0));
	enemies[0].add(new Animation("assets/sprites/Scavengers_SpriteSheet.png", Vector2(192.0f, 0.0f), 6));
	enemies[0].add(new Tracker(Vector2(608.0f, 32.0f)));

	enemies[1].add(new Position(Vector2(32, 224)));
	enemies[1].add(new Velocity(24.0f, 0.0));
	enemies[1].add(new Animation("assets/sprites/Scavengers_SpriteSheet.png", Vector2(192.0f, 0.0f), 6));
	enemies[1].add(new Tracker(Vector2(608.0f, 224.0f)));

	enemies[2].add(new Position(Vector2(32, 416)));
	enemies[2].add(new Velocity(24.0f, 0.0));
	enemies[2].add(new Animation("assets/sprites/Scavengers_SpriteSheet.png", Vector2(192.0f, 0.0f), 6));
	enemies[2].add(new Tracker(Vector2(608.0f, 415.0f)));

	engine.systems.add(new RenderSystem);
	engine.systems.add(new MovementSystem);
	engine.systems.add(new TrackerSystem);
	engine.systems.add(new AnimationSystem);
	engine.systems.add(new InputSystem);
	engine.systems.add(new AudioSystem);
	engine.systems.configure();
	while(!WindowShouldClose()) {
		engine.systems.update!InputSystem(GetFrameTime());
		engine.systems.update!AnimationSystem(GetFrameTime());
		engine.systems.update!MovementSystem(GetFrameTime());
		engine.systems.update!TrackerSystem(GetFrameTime());
		engine.systems.update!AudioSystem(GetFrameTime());
		engine.systems.update!RenderSystem(GetFrameTime());
	}
	CloseAudioDevice();
	CloseWindow();
}
