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
	Entity[3] patron;
	foreach(ref e; patron) {
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
	
	patron[0].add(new Position(Vector2(0, 200)));
	patron[0].add(new Velocity(3.0f, 0.0));
	patron[0].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[0].add(new Tracker([Vector2(162.0f, 200.0f), Vector2(162.0f, 70.0f), Vector2(280.0f, 70.0f), Vector2(280.0f, 420.0f), Vector2(576.0f, 420.0f)]));

	patron[1].add(new Position(Vector2(118, 16)));
	patron[1].add(new Velocity(3.0f, 0.0));
	patron[1].add(new Animation("assets/sprites/ServerTray.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[1].add(new Tracker([Vector2(120.0f, 16.0f), Vector2(120.0f, 18.0f), Vector2(400.0f, 18.0f), Vector2(400.0f, 100.0f), Vector2(576.0f, 100.0f)]));

	patron[2].add(new Position(Vector2(32, 416)));
	patron[2].add(new Velocity(3.0f, 0.0));
	patron[2].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[2].add(new Tracker([Vector2(120.0f, 416.0f), Vector2(120.0f, 410.0f), Vector2(448.0f, 410.0f), Vector2(448.0f, 0.0f)]));

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
