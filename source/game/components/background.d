module game.components.background;

class Background {
    import raylib;
    Texture2D image;
    this(string filename) {
        import std.string : toStringz;
        this.image = LoadTexture(filename.toStringz);
    }

    ~this() {
        UnloadTexture(this.image);
    }
}