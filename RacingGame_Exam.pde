/* //<>//
How to play the game:
Use the arrow keys to move the car sideways.
Use the Shift button to Break.
Use the Ctrl button to restart the game.
As the lapcount increase, so does the speed of the incoming cars.
*/

Racecar racecar;
Scoreboard scoreboard;
Car carLeft;
Car carRight;
Car[] carsLeft;
Car[] carsRight;
int carOffset;
float speedLeft, speedRight;
float racecarSpeed, carSpeedFactor;
int numOfCars, carFrequency, carCounter;
boolean isBreaking, isRight;

void setup() {
  size(300, 400);
  colorMode(HSB);
  racecar = new Racecar();
  racecarSpeed = 10; //how far to move by each keypress
  scoreboard = new Scoreboard(width/8*7, height/15*2);
  numOfCars = 20;
  carFrequency = 180; //how often to display a new car
  carCounter = 10;
  carSpeedFactor = 1.2; 
  carOffset = 40; //this is the last half of the car
  speedLeft = 1;
  speedRight = 1;
  carsLeft = new Car[numOfCars];
  carsRight = new Car[numOfCars];
  initLeftArr();
  initRightArr();
  isBreaking = false;
  isRight = false;
}

void draw() {
  background(100);
  if (frameCount%carFrequency == 0) {
    if (carCounter == numOfCars) {
      scoreboard.setLaps();
      println("*****NEXT LAP, PRESS CONTROL TO RESTART****");
      carCounter = 10;
    }
    carCounter++;
  }


  //GAME LOGIC
  racecar.setXpos(racecar.xPos); //move car based on keyboard entry
  racecar.display();

  for (int i = 0; i<carCounter; i++) {
   //Side detection
    //LEFT
    if (racecar.xPos < width/2) {
      isRight = false; //Driving Leftside
      if (isRight == false) {    
        if (isBreaking == true) { //Breaking LeftSide     
          speedLeft = 0.0;
          carsLeft[i].carSpeedY = speedLeft;
          carsLeft[i].move(speedLeft);
          //Drive Right side
          speedRight = float(scoreboard.laps)*carSpeedFactor; 
          carsRight[i].carSpeedY = speedRight;
          carsRight[i].move(speedRight);
        } else { 
          //Drive Left side
          speedLeft = float(scoreboard.laps)*carSpeedFactor;
          carsLeft[i].carSpeedY = speedLeft;
          carsLeft[i].move(speedLeft);
          //Drive Right side
          speedRight = float(scoreboard.laps)*carSpeedFactor; 
          carsRight[i].carSpeedY = speedRight;
          carsRight[i].move(speedRight);
        }
      }
    } else {
      //RIGHT
      if (isBreaking == true) { //Breaking RightSide       
        speedRight = 0.0;
        carsRight[i].carSpeedY = speedRight;
        carsRight[i].move(speedRight);    
        //Driving Left side
        speedLeft = float(scoreboard.laps)*carSpeedFactor;
        carsLeft[i].carSpeedY = speedLeft;
        carsLeft[i].move(speedLeft);
      } else { 
        //Drive Left side
        speedLeft = float(scoreboard.laps)*carSpeedFactor;
        carsLeft[i].carSpeedY = speedLeft;
        carsLeft[i].move(speedLeft);
        //Drive Right side
        speedRight = float(scoreboard.laps)*carSpeedFactor; 
        carsRight[i].carSpeedY = speedRight;
        carsRight[i].move(speedRight);
      }
    }

    //CRASH CONTROL
    if (racecar.intersect(carsLeft[i]) || racecar.intersect(carsRight[i])) {
      println("*********BANG!!!! CRASH!!!!*****PRESS CONTROL TO RESTART*****");
      carFrequency = 6000; // while crashed, slow down the creation of new cars
      speedLeft = 0.0;
      carsLeft[i].move(speedLeft);
      carsLeft[i].endPassed(); //move out of view
      speedRight = 0.0;
      carsRight[i].move(speedRight);
      carsRight[i].endPassed(); //move out of view
    }    

    //SCORE CONTROL    
    //the passing of the racecar without hitting it, is a score
    if (carsLeft[i].yPos-carOffset > height+1){   
      scoreboard.setScore(1);
      carsLeft[i].endPassed();
    } else if (carsRight[i].yPos-carOffset > height+1){ 
      scoreboard.setScore(1);
      carsRight[i].endPassed();
    }
    carsLeft[i].display();
    carsRight[i].display();
    scoreboard.display();
  }
}
//ARRAY INITS
void initLeftArr() {
  for (int i=0; i<numOfCars; i++) {
    int carColor = int(random(255));
    float yPos = 0-height/5;
    carLeft = new Car(carColor, speedLeft, width/8*2);
    carsLeft[i] = carLeft;
  }
}

void initRightArr() {
  for (int i=0; i<numOfCars; i++) {
    int carColor = int(random(255));
    float yPos = 0-height/5;
    carRight = new Car(carColor, speedRight, width/8*6);
    carsRight[i] = carRight;
  }
}
// KEYBOARD CONTROLS
void keyReleased() {
  if (keyCode == SHIFT) {
    isBreaking = false;
  }
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      racecar.xPos = racecar.xPos+racecarSpeed;
    }
    if (keyCode == LEFT) {
      racecar.xPos = racecar.xPos-racecarSpeed;
    }
    if (keyCode == SHIFT) {
      //brake the entered track
      isBreaking = true;
    }
    if (keyCode == CONTROL) {
      //restart game
      initLeftArr();
      initRightArr();
      carFrequency = 180;
    }
  }
}
