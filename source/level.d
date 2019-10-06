import star.entity : Engine, Entity;
class Level : Engine {
    import raylib;
    import game.components;
    import game.systems;

    this() {
        systems.add(new RenderSystem);
        systems.add(new MovementSystem);
        systems.add(new AnimationSystem);
        systems.add(new InputSystem);
        systems.add(new AudioSystem);
        systems.add(new CollisionSystem);
        systems.add(new DeathSystem);
        systems.add(new FoodSystem);
        systems.add(new UISystem);
        systems.configure();
	}

    void load() {
        SetWindowSize(640, 480);
		auto player = entities.create();
		auto oakRoom = entities.create();
		Entity[3] patron;
		foreach(ref e; patron) {
			e = entities.create();
		}
		Entity[3] food;
		foreach(ref e; food) {
			e = entities.create();
		}

		oakRoom
            .add(new Audio("assets/audio/cafe_bg.ogg"))
		    .add(new Background("assets/sprites/Room.png"))
		    .add(new Position(Vector2(0.0f, 0.0f)));

		player
            .add(new Position(Vector2(32, 350)))
            .add(new Animation("assets/sprites/Mack5.png", Vector2(0.0f, 0.0f), 5, Vector2(64.0f, 64.0f)))
            .add(new Controllable())
            .add(new Velocity())
            .add(new Collidable(Rectangle(16.0f, 0.0f, 38.0f, 64.0f)))
            .add(new Health())
            .add(new Points());
		
		patron[0]
            .add(new Position(Vector2(0, 200)))
		    .add(new Velocity(3.0f, 0.0))
		    .add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)))
		    .add(new Enemy([Vector2(162.0f, 200.0f), Vector2(162.0f, 70.0f), Vector2(280.0f, 70.0f), Vector2(280.0f, 420.0f), Vector2(576.0f, 420.0f)]))
		    .add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		patron[1]
            .add(new Position(Vector2(118, 16)))
		    .add(new Velocity(3.0f, 0.0))
		    .add(new Animation("assets/sprites/ServerTray.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)))
		    .add(new Enemy([Vector2(120.0f, 16.0f), Vector2(120.0f, 18.0f), Vector2(400.0f, 18.0f), Vector2(400.0f, 100.0f), Vector2(576.0f, 100.0f)]))
		    .add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		patron[2]
            .add(new Position(Vector2(32, 416)))
		    .add(new Velocity(3.0f, 0.0))
		    .add(new Animation("assets/sprites/LadyHat.png", Vector2(0.0f, 0.0f), 1, Vector2(64.0f, 64.0f)))
		    .add(new Enemy([Vector2(120.0f, 416.0f), Vector2(120.0f, 410.0f), Vector2(448.0f, 410.0f), Vector2(448.0f, 0.0f)]))
		    .add(new Collidable(Rectangle(12.0f, 12.0f, 42.0f, 42.0f)));

		import std.random : uniform;
		foreach(ref f; food) {
			Vector2 p = Vector2(uniform(100.0f, 500.0f), uniform(100.0f, 400.0f));
			f
             .add(new Position(p))
			 .add(new Animation("assets/sprites/Food1.png", Vector2(0.0f, 0.0f), 1, Vector2(32.0f, 32.0f)))
			 .add(new Collidable(Rectangle(0.0f, 0.0f, 32.0f, 32.0f)))
			 .add(new Pickup());
		}
    }

    void update(double dt) {
        systems.update!InputSystem(dt);
		systems.update!AnimationSystem(dt);
		systems.update!MovementSystem(dt);
		systems.update!AudioSystem(dt);
		systems.update!CollisionSystem(dt);
		systems.update!DeathSystem(dt);
		systems.update!FoodSystem(dt);
		systems.update!UISystem(dt);
		systems.update!RenderSystem(dt);
    }
}