module game.components.health;

class Health {
    uint health = 1;
    bool hit;
    this(uint health = 1) {
        this.health = health;
    }
}