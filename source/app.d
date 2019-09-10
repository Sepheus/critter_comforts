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
	engine.systems.add(new AnimationSystem);
	engine.systems.add(new InputSystem);
	engine.systems.add(new AudioSystem);
	engine.systems.add(new CollisionSystem);
	engine.systems.add(new DeathSystem);
	engine.systems.add(new FoodSystem);
	engine.systems.add(new UISystem);
	engine.systems.add(new SceneSystem);
	engine.systems.configure();

	TitleScreen();
	
	while(!WindowShouldClose()) {
		engine.systems.update!InputSystem(GetFrameTime());
		engine.systems.update!SceneSystem(GetFrameTime());
		engine.systems.update!AnimationSystem(GetFrameTime());
		engine.systems.update!MovementSystem(GetFrameTime());
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
	Texture2D image, image2, logo;
	int frameCount = 0;
	Vector2 pos = Vector2(0.0f, 0.0f);
	float scale = 1.0f;
	float fade = 1.0f;
	logo = LoadTexture("assets/sprites/Coffee3.png".toStringz);
	image = LoadTexture("assets/sprites/Mctosh640.png".toStringz);
	image2 = LoadTexture("assets/sprites/MackHouse640.png".toStringz);
	while(!IsKeyPressed(KEY_ENTER) && !WindowShouldClose()) {
		BeginDrawing();
		ClearBackground(BLACK);
		if(GetTime() < 2.0f) {
			DrawTextureV(logo, Vector2(0.0f, 70.0f), WHITE);
		}
		else if(GetTime() > 2.0f && GetTime() < 4.0f) { 
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
	UnloadTexture(logo);
	UnloadTexture(image);
	UnloadTexture(image2);
}