module game.systems.movement;
import star.entity : System, EventManager, EntityManager;
class MovementSystem : System {
    import raylib : Vector2, GetTime;
    import std.math : abs;
    import game.components : Position;
    import game.components : Velocity;
    import game.components : Controllable;
    import game.components : Enemy;
    void configure(EventManager events) { }
    void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Position, Velocity, Controllable)()) {
            auto p = entity.component!Position();
            auto v = entity.component!Velocity();
            import raymath : Vector2Lerp, Vector2Add, Vector2Scale, Vector2Zero;
            //p.position = Vector2Add(p.position, Vector2Scale(v.velocity, dt));
            if(p.isLerping) {
                float timePassed = GetTime() - p.timeStarted;
                float pct = timePassed / 0.2f;
                p.endPos = (p.endPos == Vector2Zero()) ? Vector2Add(p.position, v.velocity) : p.endPos;
                p.position = Vector2Lerp(p.position, p.endPos, pct);
                if(pct >= 1.0f) { p.isLerping = false; }
            }
            //e.position = Vector2Lerp(e.position, Vector2(e.position.x + 5.0f, e.position.y + 5.0f), 5.0f * dt);
            /*p.position.x += v.velocity.x;
            p.position.y += v.velocity.y;*/
        }

        foreach(entity; entities.entities!(Position, Velocity, Enemy)()) {
            auto p = entity.component!Position();
            auto v = entity.component!Velocity();
            auto t = entity.component!Enemy();
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