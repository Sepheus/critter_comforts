import raylib;
import star.entity;
import game.components;
import game.systems;

void main() {
	SetConfigFlags(FLAG_VSYNC_HINT);
	InitWindow(640, 640,"Critter Comforts");
	SetTargetFPS(60);
	InitAudioDevice();
    Camera2D camera;

	auto engine = new Engine();
	engine.systems.add(new RenderSystem);
	engine.systems.add(new MovementSystem);
	engine.systems.add(new PathingSystem);
	engine.systems.add(new AnimationSystem);
	engine.systems.add(new InputSystem);
	engine.systems.add(new AudioSystem);
	engine.systems.add(new CollisionSystem);
	engine.systems.add(new DeathSystem);
	engine.systems.add(new FoodSystem);
	engine.systems.add(new UISystem);
	engine.systems.configure();

	TitleScreen();
	OakRoom(engine);
	
	while(!WindowShouldClose()) {
		engine.systems.update!InputSystem(GetFrameTime());
		engine.systems.update!AnimationSystem(GetFrameTime());
		engine.systems.update!MovementSystem(GetFrameTime());
		engine.systems.update!PathingSystem(GetFrameTime());
		engine.systems.update!AudioSystem(GetFrameTime());
		engine.systems.update!CollisionSystem(GetFrameTime());
		engine.systems.update!DeathSystem(GetFrameTime());
		engine.systems.update!FoodSystem(GetFrameTime());
		engine.systems.update!UISystem(GetFrameTime());
		engine.systems.update!RenderSystem(GetFrameTime());
	}
	CloseAudioDevice();
	CloseWindow();
}


void TitleScreen() {
    import std.string : toStringz;
	Texture2D image, image2;
	int frameCount = 0;
	Vector2 pos = Vector2(0.0f, 0.0f);
	float scale = 1.0f;
	float fade = 1.0f;
	image = LoadTexture("assets/sprites/Mctosh640.png".toStringz);
	image2 = LoadTexture("assets/sprites/MackHouse640.png".toStringz);
	while(!IsKeyPressed(KEY_ENTER) && !WindowShouldClose()) {
		BeginDrawing();
		ClearBackground(BLACK);
		if(GetTime() < 2.0f) { 
			DrawTextureEx(image, pos, 0.0f, scale, WHITE);
		}
		else {
			if(pos.x > -3000 && pos.y > -3000) {
				frameCount++;
				if(frameCount >= 60/30) {
					scale += 0.1;
					frameCount = 0;
					pos.x-=30;
					pos.y-=60;
					fade -= 0.02;
				}
				DrawTextureEx(image, pos, 0.0f, scale, Fade(WHITE, fade));
			}
			else {
				DrawTextureEx(image2, Vector2(0.0f, 0.0f), 0.0f, 1.0f, WHITE);
			}
			}
		EndDrawing();
	}
}

void OakRoom(ref Engine engine) {
		SetWindowSize(640, 480);
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
			f.add(new Position(Vector2(uniform(76.0f, 560.0f), uniform(64.0f, 520.0f))));
			f.add(new Animation("assets/sprites/Food1.png", Vector2(0.0f, 0.0f), 1, Vector2(32.0f, 32.0f)));
			f.add(new Collidable());
			f.add(new Pickup());
		}
	}
