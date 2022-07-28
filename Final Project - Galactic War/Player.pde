//Player class
class Player {
  PVector position, velocity;//Position and velocity vectors
  float x, y;//X and y
  PImage ship;//Ship state
  float speed;//Speed

  //Player constructor
  Player(float speed, float x, float y) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    position = new PVector(this.x, this.y);//Set position to x and y 
    velocity = new PVector(this.speed, this.speed);//Set velocity to speed
    this.speed = 15;//Initial speed is 0
    //Set speed to 15
  }
  //Display method (no return)
  void display(PImage ship) {//Displays given ship state (image)
    position.add(velocity);//Add velocity to position
    this.ship = ship;
    image(this.ship, position.x, position.y, 120, 120);//Draw spaceship
  }
  //Spaceship movement control methods
  
  //Move left method (no return)
  void moveLeft() {//Moves spaceship left
    velocity.x = -this.speed;//Set velocity x to negative speed 
    velocity.y = 0;//Set velocity y to 0
  }
  //Move right method (no return)
  void moveRight() {//Moves spaceship right
    velocity.x = this.speed;//Set velocity x to speed
    velocity.y = 0;//Set velocity y to 0
  }
  //Move up method (no return)
  void moveUp() {//Moves spaceship up
    velocity.x = 0;//Set velocity x to 0
    velocity.y = -this.speed;//Set velocity y to negative speed
  }
  //Move down method (no return)
  void moveDown() {//Moves spaceship down
    velocity.x = 0;//Set velocity x to 0
    velocity.y = this.speed;//Set velocity y to speed 
  }
  //Stop x (no return)
  void stopX() {//Stops horizontal movement
    velocity.x = 0;//Set velocity x to 0
  }
  //Stop y (no return)
  void stopY() {//Stops vertical movement
    velocity.y = 0;//Set velocity y to 0
  }
}
