/*
Click anywhere on the screen 20 times!
*/

//Declare clickCount
int clickCount;
//Declare x and y coordinate arrays
float [] x, y;
//Declare center and smaller circle radii
int centerCircleRad, smallerCircleRad;
//Declare max number of user clicks
int maxClick;


//Create setup function
void setup() {
  //Create 900 x 600 run window
  size(900,600);
  //Set clickCount initial value to 0
  clickCount = 0;
  //Set max number of clicks to 20
  maxClick = 20;
  //Initialize x and y arrays
  //Each with 20 elements (for 20 different coordinates)
  x = new float [20];
  y = new float [20];
  //Initialize radii
  centerCircleRad = 50;
  smallerCircleRad = 18;
}

//Create draw function
void draw() {
  //Set ellipse mode to radius
  ellipseMode(RADIUS);
  //If click count has reached max:
  if(clickCount == maxClick) {
    //Loop 20 times
    for(int i = 0; i < maxClick; i++) {
      //Draw line with first point at center circle and second at each coordinate stored in x and y arrays, respectively 
      line(width/2, height/2, x[i], y[i]);
      //Draw smaller circles at each coordinate in arrays
      circle(x[i], y[i], smallerCircleRad);
    }
    //Draw center circle at center of screen
    circle(width/2, height/2, centerCircleRad);
  }
}

//Create mousePressed function
void mousePressed() {
  //If clickCount has not reached max yet:
  if(clickCount != maxClick) {
    //Store current mouseX coordinate in x array (at current click count index)
    x[clickCount] = mouseX;
    //Store current mouseY coordinate in y array (at current click count index)
    y[clickCount] = mouseY;
    //Increment click count by 1 
    clickCount++;
  }
}
