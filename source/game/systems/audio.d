module game.systems.audio;

import star.entity : System, EntityManager, EventManager;
class AudioSystem : System {
    import raylib;
    import game.components : Audio;
	void configure(EventManager events) { }
	void update(EntityManager entities, EventManager events, double dt) {
        foreach(entity; entities.entities!(Audio)()) {
            auto e = entity.component!Audio();
            UpdateMusicStream(e.audio);
		}
	}
}