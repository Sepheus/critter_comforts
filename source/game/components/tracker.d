module game.components.tracker;

class Tracker {
    import raylib : Vector2, GetTime;
    import raymath : Vector2Zero;
    Vector2 position;
    int frameCounter;
    bool isLerping;
    double timeStarted;
    Vector2 startPos;
    Vector2 endPos;

    this(Vector2 position) {
        this.position = position;
    }

    void startLerp() {
        if(!isLerping) {
            isLerping = true;
            timeStarted = GetTime();
            startPos = this.position;
            endPos = Vector2Zero();
        }
    }
}