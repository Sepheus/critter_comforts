module game.systems.collision;
import star.entity : System, EventManager, EntityManager;
class CollisionSystem : System {
    import raylib : Vector2, GetTime, CheckCollisionRecs, Rectangle;
	import game.components : Position, Velocity, Collidable, Pathing, Controllable, Health, Pickup;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
		foreach(entity; entities.entities!(Position, Collidable, Pathing)()) {
			auto p1 = entity.component!Position();
            foreach(e; entities.entities!(Position, Collidable, Controllable)()) {
                if(e.id != entity.id) {
                    auto p2 = e.component!Position();
                    auto player = e.component!Health();
                    if(CheckCollisionRecs(
                        Rectangle(p1.position.x, p1.position.y, 32.0f, 32.0f), 
                        Rectangle(p2.position.x, p2.position.y, 32.0f, 32.0f))) {
                        if(!player.hit) { player.hit = true; player.health--; }
                    }
                }
            }
		}
        foreach(entity; entities.entities!(Position, Collidable, Pickup)()) {
			auto p1 = entity.component!Position();
            auto obj = entity.component!Pickup();
            foreach(e; entities.entities!(Position, Collidable, Controllable)()) {
                if(e.id != entity.id) {
                    auto p2 = e.component!Position();
                    auto player = e.component!Health();
                    if(CheckCollisionRecs(
                        Rectangle(p1.position.x, p1.position.y, 32.0f, 32.0f), 
                        Rectangle(p2.position.x, p2.position.y, 32.0f, 32.0f))) {
                        if(!obj.taken) { obj.taken = true; }
                    }
                }
            }
		}
	}
}