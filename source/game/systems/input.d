module game.systems.input;
import star.entity : System, EntityManager, EventManager;
class InputSystem : System {
	import game.components : Position, Animation, Controllable, Velocity;
    import raylib;
    import raymath : Vector2Zero;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Controllable, Velocity, Position)()) {
			auto e = entity.component!Controllable();
            auto v = entity.component!Velocity();
            auto p = entity.component!Position();
            if(IsKeyPressed(KEY_RIGHT)) { p.startLerp(); v.velocity.x = 32.0f; }
            else if(IsKeyPressed(KEY_LEFT)) { p.startLerp(); v.velocity.x = -32.0f; }
            else if(IsKeyPressed(KEY_UP)) { p.startLerp(); v.velocity.y = -32.0f; }
            else if(IsKeyPressed(KEY_DOWN)) { p.startLerp(); v.velocity.y = 32.0f; }
            else { v.velocity = Vector2Zero(); }
		}
	}
}