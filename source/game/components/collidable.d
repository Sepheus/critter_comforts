module game.components.collidable;

class Collidable {
    import raylib : Rectangle, Vector2;
    bool enabled;
    Rectangle hitbox;
    Vector2 offset;
    this(Rectangle hitbox, bool enabled = true) {
        this.enabled = enabled;
        this.hitbox = hitbox;
        this.offset = Vector2(hitbox.x, hitbox.y);
    }
}