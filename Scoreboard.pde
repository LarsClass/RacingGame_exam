class Scoreboard {
  int score, laps;
  float xPos, yPos;
  float w, h;
  PFont fPoint;
  PFont fLaps;

  Scoreboard(float x, float y) {
    score = 0;
    laps = 1;
    xPos = x;
    yPos = y;
    w = width/8*2;
    h = height/15;
    fLaps = createFont("ArialMT-48", 12);
    fPoint = createFont("ArialMT-48", 12);
  }

  void setScore(int factor) {
    score = score + factor;
    println("you scored a point");
  }

  void setLaps() {
    laps++;
  }

  void display() {
    fill(100);
    strokeWeight(4);
    rectMode(CENTER);
    rect(xPos, yPos, w, h);
    strokeWeight(1);
    textFont(fPoint, 12);
    textFont(fLaps, 12);
    fill(255);
    text("Score: "+score, xPos-30, yPos);
    text("Laps: "+laps, xPos-30, yPos+12);
  }
}
