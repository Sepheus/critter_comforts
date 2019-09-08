module game.systems.render;
import star.entity : System, EntityManager, EventManager;
import raygui;
class RenderSystem : System {
	import game.components : Position, Animation, Background, Pickup, Velocity, Collidable, Points;
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

		/*foreach(entity; entities.entities!(Collidable)()) {
			auto p = entity.component!Position();
			DrawRectangleLinesEx(Rectangle(p.position.x, p.position.y, 64.0f, 64.0f), 1, GREEN);
		}*/

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
		foreach(entity; entities.entities!(Points)()) {
			auto score = entity.component!Points();
			GuiProgressBar(Rectangle(520, 30, 100, 20), "POINTS!", score.points, 0.0f, score.max, false);
		}
		EndDrawing();
	}
}