//Declare distance and diameters of 3 circles 
float distance;
int dmtr1, dmtr2, dmtr3;

//Declare corresponding color of circles and mouse location
color white;
color circleColor1, circleColor2, circleColor3;
String mouseLocation;

//Create setup function
void setup() {
  //Create 900 x 900 window
  size(900, 900);
  //Set diameter of circle 1 to 600, circle 2 to 400, and circle 3 to 200
  dmtr1 = 600;
  dmtr2 = 400;
  dmtr3 = 200;

  white = color(#fefcfe);
}

//Create draw function
void draw() {
  //Set distance equal to distance between center of window and mouse position
  distance = dist(width/2, height/2, mouseX, mouseY);
  
  //Change background color to white
  background(#fefcfe);
  
  //Set initial color of three circles to white
  circleColor1 = color(white);
  circleColor2 = color(white);
  circleColor3 = color(white);
  
  //Check if distance within radius of LARGE circle and outside radius of MEDIUM circle
  if ((distance <= dmtr1 / 2) && (distance > dmtr2 / 2 )) {
    //Change mouse location to LARGE
    mouseLocation = "LARGE";
    //Change color of LARGE circle to red
    circleColor1 = color(#ff1a23);
    
    //Otherwise, check if distance within radius of MEDIUM circle and outside radius of SMALL circle
  } else if ((distance <= dmtr2 / 2) && (distance > dmtr3 / 2 )) {
    //Change mouse location to MEDIUM
    mouseLocation = "MEDIUM";
    //Change color of MEDIUM circle to green
    circleColor2 = color(#06d300);
    
    //Otherwise, check if distance within radius of SMALL circle
  } else if (distance <= dmtr3 / 2) {
    //Change mouse location to SMALL
    mouseLocation = "SMALL";
    //Change color of SMALL circle to yellow
    circleColor3 = color(#f4e300);
    
    //Else, if distance not within radii of any circles, set mouseLocation to NONE (will not effect color of any circles)
  } else {
    mouseLocation = "NONE";
  }
  
  //Create circles using fill color stored in each "circleColor" 
  //LARGE circle
  fill(circleColor1);
  ellipse(width/2, height/2, dmtr1, dmtr1);
  
  //MEDIUM circle
  fill(circleColor2);
  ellipse(width/2, height/2, dmtr2, dmtr2);
  
  //SMALL circle
  fill(circleColor3);
  ellipse(width/2, height/2, dmtr3, dmtr3);
  
  //Check if mouse location at LARGE circle
  if(mouseLocation == "LARGE") {
   //Create circle at mouse position
   ellipse(mouseX, mouseY, 20, 20);
   
 //Check if mouse location at MEDIUM circle
  } else if(mouseLocation == "MEDIUM") {
    //Create rectangle at mouse position
    rect(mouseX, mouseY, 20, 20);
    
 //Check if mouse location at SMALL circle 
  } else if(mouseLocation == "SMALL") {
    //Create horizontal line at mouse position
    line(mouseX - 10, mouseY, mouseX + 10, mouseY);
    //Create vertical line at mouse position
    line(mouseX, mouseY - 10, mouseX, mouseY + 10);
  }
}
