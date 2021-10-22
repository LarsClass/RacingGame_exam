class Car {
  //Variables
  float xPos;
  float yPos;
  float carSpeedX, carSpeedY;
  int sizeX, sizeY;
  int direction;
  int carColor;
  
  //Constructor
  Car(int col, float speed, float posX){
   xPos = posX;
   yPos = 0-height/5;
   sizeX = width/4;
   sizeY = height/5;
   carColor = col;
   carSpeedX = 0;
   carSpeedY = speed; 
   direction = 1;
  }
    
  //Methods
  void move(float carSpeedY){
   yPos = yPos+carSpeedY;
  }
 
  void moveX(){
   xPos = xPos+(carSpeedX*direction);
  }
  
  void endPassed(){
   xPos = width*10;
   yPos = height*-10;
   carSpeedY = 0.0;
  }
  
  void display(){
    rectMode(CENTER);
    ellipseMode(CENTER);
    stroke(0);
    fill(carColor,100,200);    
    rect(xPos, yPos-20, width/4, height/60); //axel
    rect(xPos, yPos+20, width/4, height/60); //axel
    ellipse(xPos, yPos, width/7, height/5); //body
    fill(0);
    rect(xPos-32, yPos-20, width/32, height/15); //wheel
    rect(xPos+32, yPos-20, width/32, height/15); //wheel
    rect(xPos-30, yPos+20, width/25, height/15); //rearwheel
    rect(xPos+30, yPos+20, width/25, height/15); //rearwheel
    fill(255);
    ellipse(xPos, yPos+10, width/16, height/10); //driver  
  }
  
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
}
