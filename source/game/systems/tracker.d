module game.systems.tracker;
import star.entity : System, EventManager, EntityManager;
class TrackerSystem : System {
    import raylib : Vector2, GetTime;
	import game.components : Position, Velocity, Tracker;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
		foreach(entity; entities.entities!(Position, Velocity, Tracker)()) {
			auto p = entity.component!Position();
            auto v = entity.component!Velocity();
            auto t = entity.component!Tracker();
            import raymath : Vector2Lerp, Vector2Add, Vector2Scale, Vector2Zero;

            /*t.frameCounter++;
            if(t.frameCounter >= 60/4) {
                t.frameCounter = 0;
                if(t.position.x > (p.position.x + v.velocity.x)) { 
                    p.position.x += v.velocity.x;
                }
            }*/

            //p.position = Vector2Add(p.position, Vector2Scale(v.velocity, dt));
            if(p.position.x <= t.position.x) { p.startLerp(); }
            if(p.isLerping) {
                float timePassed = GetTime() - p.timeStarted;
                float pct = timePassed / 0.2f;
                p.endPos = (t.position == Vector2Zero()) ? t.position : p.endPos;
                p.position = Vector2Lerp(p.startPos, p.endPos, pct);
                if(pct >= 1.0f) { p.isLerping = false; }
            }
			//e.position = Vector2Lerp(e.position, Vector2(e.position.x + 5.0f, e.position.y + 5.0f), 5.0f * dt);
            /*p.position.x += v.velocity.x;
            p.position.y += v.velocity.y;*/
		}
	}
}