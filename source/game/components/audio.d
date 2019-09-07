module game.components.audio;

class Audio {
    import raylib;
    Music audio;
    this(string filename) {
        import std.string : toStringz;
        this.audio = LoadMusicStream(filename.toStringz);
        PlayMusicStream(this.audio);
    }

    ~this() {
        UnloadMusicStream(this.audio);
    }
}