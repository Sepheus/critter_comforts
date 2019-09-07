module game.components.pickup;

class Pickup {
    bool taken;
    bool enabled;
    this(bool enabled = true) {
        this.enabled = enabled;
    }
}