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
	auto enemy = engine.entities.create();
	player.add(new Position(Vector2(320, 240)));
	player.add(new Animation("assets/sprites/Scavengers_SpriteSheet.png", Vector2(0.0f, 0.0f), 6));
	player.add(new Controllable());
	player.add(new Velocity());
	enemy.add(new Position(Vector2(360, 240)));
	enemy.add(new Animation("assets/sprites/Scavengers_SpriteSheet.png", Vector2(192.0f, 0.0f), 6));
	engine.systems.add(new RenderSystem);
	engine.systems.add(new MovementSystem);
	engine.systems.add(new AnimationSystem);
	engine.systems.add(new InputSystem);
	engine.systems.configure();
	while(!WindowShouldClose()) {
		engine.systems.update!InputSystem(GetFrameTime());
		engine.systems.update!AnimationSystem(GetFrameTime());
		engine.systems.update!MovementSystem(GetFrameTime());
		engine.systems.update!RenderSystem(GetFrameTime());
	}
	CloseWindow();
}
