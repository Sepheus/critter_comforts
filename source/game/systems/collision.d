module game.systems.collision;
import star.entity : System, EventManager, EntityManager;
class CollisionSystem : System {
    import raylib : Vector2, GetTime, CheckCollisionRecs, Rectangle;
    import game.components : Position, Velocity, Collidable, Enemy, Controllable, Health, Pickup;
    void configure(EventManager events) { }
    void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Position, Collidable)) {
            auto p = entity.component!Position();
            auto h = entity.component!Collidable();
            h.hitbox.x = p.position.x + h.offset.x;
            h.hitbox.y = p.position.y + h.offset.y;
        }
        foreach(entity; entities.entities!(Collidable, Enemy)()) {
            auto p1 = entity.component!Collidable();
            foreach(e; entities.entities!(Collidable, Controllable)()) {
                if(e.id != entity.id) {
                    auto p2 = e.component!Collidable();
                    auto player = e.component!Health();
                    if(CheckCollisionRecs(p1.hitbox, p2.hitbox)) {
                        if(!player.hit) { player.hit = true; player.health--; }
                    }
                }
            }
        }
        foreach(entity; entities.entities!(Collidable, Pickup)()) {
            auto p1 = entity.component!Collidable();
            auto obj = entity.component!Pickup();
            foreach(e; entities.entities!(Collidable, Controllable)()) {
                if(e.id != entity.id) {
                    auto p2 = e.component!Collidable();
                    if(CheckCollisionRecs(p1.hitbox, p2.hitbox)) {
                        if(!obj.taken) { obj.taken = true; }
                    }
                }
            }
        }
    }
}