module game.systems.food;

import star.entity : System, EntityManager, EventManager;
class FoodSystem : System {
    import raylib;
    import std.random : uniform;
    import std.algorithm : clamp;
    import game.components : Collidable, Pickup, Animation, Position, Pathing, Points;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
        Vector2[] newPos;
        bool scored = false;
        foreach(entity; entities.entities!(Pathing)()) {
            auto p = entity.component!Position();
            newPos ~= p.position;
        }
        foreach(entity; entities.entities!(Collidable, Animation, Pickup)()) {
            auto obj = entity.component!Pickup();
            if(obj.taken) {
                scored = true;
                auto p = entity.component!Position();
                auto sprite = entity.component!Animation();
                p.position = newPos[uniform(0, newPos.length)];
                obj.taken = false;
            }
		}
        if(scored) {
            foreach(entity; entities.entities!(Points)()) {
                auto p = entity.component!Points();
                p.points += 2;
                if(p.points > p.max)  { p.points = p.max; }
            }
        }
	}
}