//Create setup function
void setup() {
  size(532, 720);
}

//Create draw function
void draw() {
  //Face
  strokeWeight(1);
  fill(239, 247, 85);
  rectMode(CENTER);
  rect(266, 220, 340, 370);
  
  //Left eyelashes
  stroke(1);
  strokeWeight(5);
  line(215, 107, 215, 80);
  line(199, 110, 170, 80);
  line(231, 110, 255, 80);
  
  //Right eyelashes
  line(325, 107, 325, 80);
  line(309, 110, 280, 80);
  line(341, 110, 365, 80);
  
  //Left eye
  strokeWeight(1);
  fill(255);
  ellipse(215, 170, 110, 130);
  
  //Left pupil
  fill(110, 230, 251);
  ellipse(215, 170, 55, 65);
  fill(0);
  ellipse(215, 170, 27.5, 32.5);
  
  //Left pupil shine
  noStroke();
  fill(255);
  ellipse(209, 160, 12, 15);
  
  //Right eye
  stroke(0);
  fill(255);
  ellipse(325, 170, 110, 130);
  
  //Right pupil
  stroke(0);
  fill(110, 230, 251);
  ellipse(325, 170, 55, 65);
  fill(0);
  ellipse(325, 170, 27.5, 32.5);
  
  //Right pupil shine
  noStroke();
  fill(255);
  ellipse(319, 160, 12, 15);
  
  //Mouth
  noFill();
  stroke(0);
  strokeWeight(5);
  arc(266, 245, 190, 140, 0, PI);   
  line(158, 249, 182, 238);
  line(374, 249, 350, 238);

  //Left tooth
  fill(255);
  beginShape(); 
  vertex(216, 305);
  vertex(216, 345);
  vertex(250, 345);
  vertex(250, 315);
  endShape(CLOSE);
   
  //Right tooth
  fill(255);
  beginShape(); 
  vertex(276, 315);
  vertex(276, 345);
  vertex(310, 345);
  vertex(310, 307);
  endShape(CLOSE);
  
  //Left arm
  strokeWeight(1);
  fill(239, 247, 85);
  rect(80, 470, 17, 70);
  
  //Right arm
  rect(455, 470, 17, 70);
  
  //Left hand
  strokeWeight(1);
  fill(239, 247, 85);
  ellipse(80, 495, 40, 40);
  
  //Right hand
  ellipse(456, 495, 40, 40);
  
  //Suit
  strokeWeight(1);
  fill(255);
  rect(266, 430, 340, 120);
  
  fill(161, 122, 36);
  rect(266, 443, 340, 95);
  
  fill(161, 122, 36);
  rect(170, 505, 60, 30);
  
  fill(161, 122, 36);
  rect(360, 505, 60, 30);
  
  fill(255);
  triangle(96, 436, 96, 369, 57, 436);
  triangle(435, 436, 435, 369, 474, 436);

  //Tie
  fill(182, 50, 42);
  triangle(228, 370, 262, 395, 296, 370); 
  quad(228, 461, 262, 395, 296, 461, 262, 489);
  
  //Left leg
  fill(239, 247, 85);
  rect(170, 580, 30, 120);
  
  //Right leg
  rect(360, 580, 30, 120);
  
  //Left shoe
  fill(0);
  ellipse(158, 627, 80, 40);
  
  //Right shoe
  ellipse(375, 627, -80, 40);
}
