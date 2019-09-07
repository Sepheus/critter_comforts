import raylib;
import star.entity;
import game.components;
import game.systems;

void main() {
	SetConfigFlags(FLAG_VSYNC_HINT);
	InitWindow(640, 480,"Critter Comforts");
	SetTargetFPS(60);
    Camera2D camera;
	auto engine = new Engine();
	auto player = engine.entities.create();
	auto oakRoom = engine.entities.create();
	Entity[3] patron;
	foreach(ref e; patron) {
		e = engine.entities.create();
	}
	Entity[3] food;
	foreach(ref e; food) {
		e = engine.entities.create();
	}
	InitAudioDevice();

	oakRoom.add(new Audio("assets/audio/cafe_bg.ogg"));
	oakRoom.add(new Background("assets/sprites/Room.png"));
	oakRoom.add(new Position(Vector2(0.0f, 0.0f)));

	player.add(new Position(Vector2(32, 350)));
	player.add(new Animation("assets/sprites/Mack5.png", Vector2(0.0f, 0.0f), 5, Vector2(64.0f, 64.0f)));
	player.add(new Controllable());
	player.add(new Velocity());
	player.add(new Collidable());
	player.add(new Health());
	
	patron[0].add(new Position(Vector2(0, 200)));
	patron[0].add(new Velocity(3.0f, 0.0));
	patron[0].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[0].add(new Pathing([Vector2(162.0f, 200.0f), Vector2(162.0f, 70.0f), Vector2(280.0f, 70.0f), Vector2(280.0f, 420.0f), Vector2(576.0f, 420.0f)]));
	patron[0].add(new Collidable());

	patron[1].add(new Position(Vector2(118, 16)));
	patron[1].add(new Velocity(3.0f, 0.0));
	patron[1].add(new Animation("assets/sprites/ServerTray.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[1].add(new Pathing([Vector2(120.0f, 16.0f), Vector2(120.0f, 18.0f), Vector2(400.0f, 18.0f), Vector2(400.0f, 100.0f), Vector2(576.0f, 100.0f)]));
	patron[1].add(new Collidable());

	patron[2].add(new Position(Vector2(32, 416)));
	patron[2].add(new Velocity(3.0f, 0.0));
	patron[2].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
	patron[2].add(new Pathing([Vector2(120.0f, 416.0f), Vector2(120.0f, 410.0f), Vector2(448.0f, 410.0f), Vector2(448.0f, 0.0f)]));
	patron[2].add(new Collidable());

	import std.random : uniform;
	foreach(ref f; food) {
		f.add(new Position(Vector2(uniform(0.0f, 640.0f), uniform(0.0f, 480.0f))));
		f.add(new Animation("assets/sprites/Food1.png", Vector2(0.0f, 0.0f), 1, Vector2(32.0f, 32.0f)));
		f.add(new Collidable());
		f.add(new Pickup());
	}

	engine.systems.add(new RenderSystem);
	engine.systems.add(new MovementSystem);
	engine.systems.add(new PathingSystem);
	engine.systems.add(new AnimationSystem);
	engine.systems.add(new InputSystem);
	engine.systems.add(new AudioSystem);
	engine.systems.add(new CollisionSystem);
	engine.systems.add(new DeathSystem);
	engine.systems.add(new FoodSystem);
	engine.systems.configure();

	while(!WindowShouldClose()) {
		engine.systems.update!InputSystem(GetFrameTime());
		engine.systems.update!AnimationSystem(GetFrameTime());
		engine.systems.update!MovementSystem(GetFrameTime());
		engine.systems.update!PathingSystem(GetFrameTime());
		engine.systems.update!AudioSystem(GetFrameTime());
		engine.systems.update!CollisionSystem(GetFrameTime());
		engine.systems.update!DeathSystem(GetFrameTime());
		engine.systems.update!FoodSystem(GetFrameTime());
		engine.systems.update!RenderSystem(GetFrameTime());
	}
	CloseAudioDevice();
	CloseWindow();
}
