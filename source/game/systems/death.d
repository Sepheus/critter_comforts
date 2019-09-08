module game.systems.death;

import star.entity : System, EntityManager, EventManager;
class DeathSystem : System {
    import raylib;
    import game.components : Controllable, Position, Health, Points;
    import std.algorithm : clamp;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Controllable, Health)()) {
            auto player = entity.component!Health();
            auto pts = entity.component!Points();
            if(player.hit && player.health <= 0) {
                auto p = entity.component!Position();
                p.position = Vector2(32.0f, 350.0f);
                pts.points -= 1;
                pts.points = pts.points.clamp(0, pts.points.max);
                p.isLerping = false;
                player.hit = false;
                player.health = 1;
            }
		}
	}
}