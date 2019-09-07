module game.components.pathing;

class Pathing {
    import raylib : Vector2, GetTime;
    import raymath : Vector2Zero;
    Vector2[] positions;
    Vector2 position;
    int calls;
    bool reverse;

    this(Vector2[] positions) {
        import std.algorithm.mutation : reverse;
        this.positions = positions ~ positions.dup.reverse;
        this.position = positions[0];
    }

    void next() {
        if(positions.length >= 1) { this.positions = positions[1..$] ~ positions[0]; }
        calls++;
        if((calls % (positions.length / 2)) == 0) { calls = 0; reverse = !reverse; }
        position = this.positions[0];
    }
}