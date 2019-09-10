module game.systems.animation;
import star.entity : System, EventManager, EntityManager, Receiver;
import game.events : PauseEvent;
class AnimationSystem : System, Receiver!PauseEvent {
	import game.components : Animation;
    import raylib;
    private { bool isPaused; }
	void configure(EventManager events) { events.subscribe!PauseEvent(this); }
	void update(EntityManager entities, EventManager events, double dt) {
        if(!isPaused) {
            foreach(entity; entities.entities!(Animation)()) {
                auto animation = entity.component!Animation();
                animation.frameCounter++;
                if(animation.frameCounter >= 60/4) {
                    animation.frameCounter = 0;
                    animation.frame.x = (animation.start.x + (animation.currentFrame * animation.size.x)) % animation.sheet.width;
                    animation.frame.y = animation.size.y * cast(int)(((animation.start.x + (animation.currentFrame * animation.size.x))) / animation.sheet.width);
                    animation.currentFrame++;
                    if(animation.currentFrame >= animation.frames) { animation.currentFrame = 0; }                
                }
            }
        }
	}
    void receive(PauseEvent event) pure nothrow {
        isPaused = event.paused;
    }
}