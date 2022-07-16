//Set radius of larger circle to 60 and smaller circle to 20
int bigCircleRadius = 60;
int smallCircleRadius = 20;
//Declare x and y positions of larger circle
float xPosition, yPosition;    

//Set horizontal speed of larger circle to 2.8
float xSpeed = 2.8;  
//Set vertical speed of larger circle to 2.2
float ySpeed = 2.2; 

//Declare hit counter and max collisions
int hitCount;
int maxCollisions;

//Set horizontal and vertical starting direction of larger circle to positive 1 (going forward and upward)
int xDirection = 1;  
int yDirection = 1;  
//Declare color of big circle and collision
color bigCircleColor, collisionColor;

//Create setup function
void setup() {
  //Create 640 x 360 run window
  size(640, 360);
  //Remove stroke of circles
  noStroke();
  //Change ellipse mode to radius (takes radius and starting points as parameters for center of circle)
  ellipseMode(RADIUS);
  //Set starting position of larger circle to center of screen
  xPosition = width/2;
  yPosition = height/2;
  //Set initial hit count to 0 and max collisions to 1
  hitCount = 0;
  maxCollisions = 1;
  //Initialize colors
  bigCircleColor = color(#ffffff);
  collisionColor = color(#1927B4);
}

//Create draw function
void draw() {
  //Change background color to grey
  background(102);
  
  //Add horizontal speed multiplied by horizontal direction to x-position
  xPosition += ( xSpeed * xDirection );
  //Add vertical speed multiplied by vertical direction to y-position
  yPosition += ( ySpeed * yDirection );
  
  //If x-position of larger circle exceeds boundaries of width:
  if(xPosition > width-bigCircleRadius || xPosition < bigCircleRadius) {
    //Reverse horizontal direction by multiplying by -1
    xDirection *= -1;
  }
  //If y-position of larger circle exceeds boundaries of height:
  if(yPosition > height-bigCircleRadius || yPosition < bigCircleRadius) {
    //Reverse vertical direction by multiplying by -1
    yDirection *= -1;
  }
  //If distance between smaller circle and larger circle within sum of both radii (collision):
  if(dist(mouseX, mouseY, xPosition, yPosition) < bigCircleRadius + smallCircleRadius) {
    //Increment hit count by 1
    hitCount++;
    //If collision reaches max (1):
    if(hitCount == maxCollisions) {
      //Increment horizontal speed by 1.8 and vertical speed by 1.2
      xSpeed += 1.8;
      ySpeed += 1.2;
      //Decrement larger circle radius by 3.5;
      bigCircleRadius -= 3.5;
      //Change color of big circle to blue
      bigCircleColor = collisionColor;
    } 
  //Otherwise, if collision did not occur:
  } else {
    //Set hit count to 0
    hitCount = 0;
    //Set color of big circle to white
    bigCircleColor = color(#ffffff);
  }
  
  //Draw larger circle
  fill(bigCircleColor);
  circle(xPosition, yPosition, bigCircleRadius);
  //Draw smaller circle with white fill
  fill(#ffffff);
  circle(mouseX, mouseY, smallCircleRadius);
}
