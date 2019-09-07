module game.components.velocity;

class Velocity {
    import raylib : Vector2;
    Vector2 velocity;
    this(Vector2 velocity) {
        this.velocity = velocity;
    }
    this(float x = 0.0f, float y = 0.0f) {
        this.velocity = Vector2(x, y);
    }
}