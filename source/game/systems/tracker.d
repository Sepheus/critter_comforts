module game.systems.tracker;
import star.entity : System, EventManager, EntityManager;
class TrackerSystem : System {
    import raylib : Vector2, GetTime;
	import game.components : Position, Velocity, Tracker;
    import std.math : abs;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
		foreach(entity; entities.entities!(Position, Velocity, Tracker)()) {
			auto p = entity.component!Position();
            auto v = entity.component!Velocity();
            auto t = entity.component!Tracker();
            import raymath : Vector2Lerp, Vector2Add, Vector2Scale, Vector2Zero, Vector2Distance;

            if(Vector2Distance(p.position, t.position) >= 8.0f) { p.position = Vector2Add(p.position, v.velocity); }
            else if(Vector2Distance(p.position, t.position) < 8.0f) {
                t.next();
                if(!t.reverse) {
                    if(p.position.y - t.position.y > 0) {
                        v.velocity = Vector2(v.velocity.y.abs, -v.velocity.x);
                    }
                    else { 
                        v.velocity = Vector2(v.velocity.y.abs, v.velocity.x);
                    }
                }
                else {
                    if(p.position.y - t.position.y > 0) {
                        v.velocity = Vector2(-v.velocity.y.abs, v.velocity.x);
                    }
                    else { 
                        v.velocity = Vector2(-v.velocity.y.abs, -v.velocity.x);
                    }
                }
            }
		}
	}
}