//Set radius of larger circle to 60 and smaller circle to 20
int bigCircleRadius = 60;   
int smallCircleRadius = 20;
//Declare x and y positions of larger circle
float xPosition, yPosition;    

//Set horizontal speed of larger circle to 2.8
float xSpeed = 2.8;  
//Set vertical speed of larger circle to 2.2
float ySpeed = 2.2;  

//Set horizontal and vertical starting direction of larger circle to positive 1 (going forward and upward)
int xDirection = 1;  
int yDirection = 1;  

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
    //Change color of larger circle to blue
    fill(#0d15e0);
    //Increment horizontal speed by 0.8 and vertical speed by 0.2
    xSpeed += 0.8;
    ySpeed += 0.2;
    //Decrement larger circle radius by 0.1;
    bigCircleRadius -= 0.1;
  }
  
  //Draw larger circle
  circle(xPosition, yPosition, bigCircleRadius);
  //Draw smaller circle with white fill
  fill(225);
  circle(mouseX, mouseY, smallCircleRadius);
}
