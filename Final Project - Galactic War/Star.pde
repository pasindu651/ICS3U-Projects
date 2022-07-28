//Star class
class Star {
  PVector position, velocity;//Position and velocity vectors
  float speed, size;//Speed and size
  int randomNum;//Random number
  PImage star, diamond_star, circle_star;//Graphics for different sized stars

  //Star constructor
  Star(float speed, float size) {
    this.speed = speed;
    this.size = size;
    position = new PVector(random(width + 1), random(height + 1));//Set position to random number within screen width and screen height
    velocity = new PVector(0, this.speed);//Set velocity to 0 and speed

    //Load various sized star graphics 
    star = loadImage("star.png");//normal star
    diamond_star = loadImage("diamond_star.png");//diamond star
    circle_star = loadImage("circle_star.png");//circle star

    this.randomNum();//Generate random number
  }

  //Random number method (no return)
  void randomNum() {//Generates random number
    randomNum = int(random(3));//Generate random number between 0 and 3 
  }
  //Display method (no return)
  void display() {//Display star
    this.reset();//Reset star
    position.add(velocity);//Add velocity to position
    //If random number is 0:
    if (randomNum == 0) {
      image(star, position.x, position.y, this.size, this.size);//Draw normal star
    //If random number is 1:
    } else if (randomNum == 1) {
      image(diamond_star, position.x, position.y, this.size, this.size);//Draw diamond star
    //If random number is 2:
    } else if (randomNum == 2) {
      image(circle_star, position.x, position.y, this.size, this.size);//Draw circle star
    }
  }

  //Reset method (no return)
  void reset() {//Resets star
    //If star exceeds screen height:
    if (position.y - size > height) {
      position.y = 0;//Set position y to 0
    }
  }
}
