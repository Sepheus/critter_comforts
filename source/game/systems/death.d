module game.systems.death;

import star.entity : System, EntityManager, EventManager;
class DeathSystem : System {
    import raylib;
    import game.components : Controllable, Position, Health;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Controllable, Health)()) {
            auto player = entity.component!Health();
            if(player.hit && player.health <= 0) {
                auto p = entity.component!Position();
                p.position = Vector2(32.0f, 350.0f);
                p.isLerping = false;
                player.hit = false;
                player.health = 1;
            }
		}
	}
}