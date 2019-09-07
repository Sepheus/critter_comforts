module game.components.animation;

class Animation {
    import raylib;
    Texture2D sheet;
    Rectangle frame;
    int frameCounter;
    int currentFrame;
    int frames;
    Vector2 start;
    Vector2 size;
    this(string filename, Vector2 start, int frames, Vector2 size = Vector2(32.0f, 32.0f)) {
        import std.string : toStringz;
        this.size = size;
        this.sheet = LoadTexture(filename.toStringz);
        this.frames = frames;
        this.frame = Rectangle(start.x, start.y, size.x, size.y);
        this.start = start;
    }

    ~this() {
        UnloadTexture(this.sheet);
    }
}