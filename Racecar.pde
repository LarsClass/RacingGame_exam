class Racecar {
  //Variables
  float xPos;
  float yPos;
  int sizeX;
  int sizeY;
  
  //Constructor
  Racecar() {
    sizeX = width/4;
    sizeY = height/5;
    xPos = width/2;
    yPos = height/15*13;    
  }

  void display() {
    rectMode(CENTER);
    ellipseMode(CENTER);
    fill(0); 
    rect(xPos, yPos-20, width/4, height/60); //axel
    rect(xPos, yPos+20, width/4, height/60); //axel
    ellipse(xPos, yPos, width/7, height/5); //body
    rect(xPos-32, yPos-20, width/32, height/15); //wheel
    rect(xPos+32, yPos-20, width/32, height/15); //wheel
    rect(xPos-30, yPos+20, width/25, height/15); //rearwheel
    rect(xPos+30, yPos+20, width/25, height/15); //rearwheel
    fill(255);
    ellipse(xPos, yPos+10, width/16, height/10); //driver
  }

  //Methods
  boolean intersect(Car car) {
    boolean hit = false;
    float centerDist = dist(xPos, yPos, car.xPos, car.yPos);
    float yDist = (car.sizeY + racecar.sizeY)/2;
    float xDist = (car.sizeX + racecar.sizeX)/2;
    if (centerDist < yDist || centerDist < xDist) {
      hit = true; 
      return hit;
    }
    return hit;
  }

  void setXpos(float x) {
    //stay within the racetrack border
    xPos = constrain(x, width/8*2, width/8*6);
  }
}
