module game.systems.render;
import star.entity : System, EntityManager, EventManager;
class RenderSystem : System {
	import game.components : Position, Animation, Background;
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
			//DrawRectangleV(e.position, Vector2(10.0f, 10.0f), GREEN);
		}
        foreach(entity; entities.entities!(Position, Animation)()) {
			auto animation = entity.component!Animation();
            auto p = entity.component!Position();
			DrawTextureRec(animation.sheet, animation.frame, p.position, WHITE);
		}
		EndDrawing();
	}
}