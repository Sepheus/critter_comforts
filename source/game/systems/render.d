module game.systems.render;
import star.entity : System, EntityManager, EventManager;
import raygui;
class RenderSystem : System {
	import game.components : Position, Animation, Background, Pickup, Velocity;
    import raylib;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
		BeginDrawing();
		ClearBackground(BLACK);
		DrawFPS(10, 10);

		foreach(entity; entities.entities!(Position, Background)()) {
			auto p = entity.component!Position();
			auto bg = entity.component!Background();
			DrawTextureV(bg.image, p.position, WHITE);
		}

		foreach(entity; entities.entities!(Position, Pickup)()) {
			auto animation = entity.component!Animation();
            auto p = entity.component!Position();
			if(animation.visible) {
				DrawTextureRec(animation.sheet, animation.frame, p.position, WHITE);
			}
		}

        foreach(entity; entities.entities!(Position, Animation, Velocity)()) {
			auto animation = entity.component!Animation();
            auto p = entity.component!Position();
			if(animation.visible) {
				DrawTextureRec(animation.sheet, animation.frame, p.position, WHITE);
			}
		}
		GuiProgressBar(Rectangle(520, 30, 100, 20), "PANIC!", 50.0f, 0.0f, 100.0f, false);
		EndDrawing();
	}
}