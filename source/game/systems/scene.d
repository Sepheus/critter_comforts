module game.systems.scene;
import star.entity : System, EntityManager, EventManager, Receiver, Entity;
import game.events : SceneEvent, PauseEvent;
class SceneSystem : System, Receiver!SceneEvent {
    import raylib;
    import game.components;
    private { bool change; string scene; bool reset = true; }
	void configure(EventManager events) { events.subscribe!SceneEvent(this); }
	void update(EntityManager entities, EventManager events, double dt) {
        if(change) {
            foreach(entity; entities.entities) {
                entity.destroy();
            }
            change = false;
        }
        if(reset) {
            OakRoom(entities);
            events.emit(PauseEvent(false));
            reset = false;
        }
	}
    void receive(SceneEvent event) pure nothrow {
        change = true;
        reset = true;
        scene = event.scene;
    }

    void OakRoom(ref EntityManager engine) {
		SetWindowSize(640, 480);
		auto player = engine.create();
		auto oakRoom = engine.create();
		Entity[3] patron;
		foreach(ref e; patron) {
			e = engine.create();
		}
		Entity[3] food;
		foreach(ref e; food) {
			e = engine.create();
		}

		oakRoom.add(new Audio("assets/audio/cafe_bg.ogg"));
		oakRoom.add(new Background("assets/sprites/Room.png"));
		oakRoom.add(new Position(Vector2(0.0f, 0.0f)));

		player.add(new Position(Vector2(32, 350)));
		player.add(new Animation("assets/sprites/Mack5.png", Vector2(0.0f, 0.0f), 5, Vector2(64.0f, 64.0f)));
		player.add(new Controllable());
		player.add(new Velocity());
		player.add(new Collidable(Rectangle(16.0f, 0.0f, 38.0f, 64.0f)));
		player.add(new Health());
		player.add(new Points());
		
		patron[0].add(new Position(Vector2(0, 200)));
		patron[0].add(new Velocity(3.0f, 0.0));
		patron[0].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
		patron[0].add(new Enemy([Vector2(162.0f, 200.0f), Vector2(162.0f, 70.0f), Vector2(280.0f, 70.0f), Vector2(280.0f, 420.0f), Vector2(576.0f, 420.0f)]));
		patron[0].add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		patron[1].add(new Position(Vector2(118, 16)));
		patron[1].add(new Velocity(3.0f, 0.0));
		patron[1].add(new Animation("assets/sprites/ServerTray.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
		patron[1].add(new Enemy([Vector2(120.0f, 16.0f), Vector2(120.0f, 18.0f), Vector2(400.0f, 18.0f), Vector2(400.0f, 100.0f), Vector2(576.0f, 100.0f)]));
		patron[1].add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		patron[2].add(new Position(Vector2(32, 416)));
		patron[2].add(new Velocity(3.0f, 0.0));
		patron[2].add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)));
		patron[2].add(new Enemy([Vector2(120.0f, 416.0f), Vector2(120.0f, 410.0f), Vector2(448.0f, 410.0f), Vector2(448.0f, 0.0f)]));
		patron[2].add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		import std.random : uniform;
		foreach(ref f; food) {
			Vector2 p = Vector2(uniform(100.0f, 500.0f), uniform(100.0f, 400.0f));
			f.add(new Position(p));
			f.add(new Animation("assets/sprites/Food1.png", Vector2(0.0f, 0.0f), 1, Vector2(32.0f, 32.0f)));
			f.add(new Collidable(Rectangle(0.0f, 0.0f, 32.0f, 32.0f)));
			f.add(new Pickup());
		}
	}

}