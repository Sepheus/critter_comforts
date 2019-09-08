module game.systems.ui;

import star.entity : System, EntityManager, EventManager;
class UISystem : System {
    import raygui : GuiSetStyle;
    import game.components : Controllable, Position, Health;
	void configure(EventManager events) { 
	    GuiSetStyle(5, 7, 0xFF0000FF);
    }
	void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Controllable, Health)()) {
		}
	}
}