//Enemy class
class Enemy {
  int size, speed, fuelProbability;//size, speed, and probability of dropping fuel
  boolean drop;//boolean fuel drop
  float randomX;//random x
  PImage enemy;//enemy graphics
  PVector position, velocity;//position and velocity vectors
  
  //Enemy constructor
  Enemy(int size, int speed) {
    this.size = size;
    this.speed = speed;
    enemy = loadImage("enemy.png");//Load enemy graphics
    this.randomX();//Generate random x value
    position = new PVector(randomX, 0);//Set position to random x value and 0
    velocity = new PVector(0, this.speed);//Set velocity to 0 and speed
  }
  //Display constructor
  void display() {//Displays enemies
    //If enemy goes off screen:
    if (position.y - size > height) {
      this.reset();//Reset enemy
    }
    position.add(velocity);//Add velocity to position
    image(enemy, position.x, position.y, this.size, this.size);//Draw enemy
  }
  //Random x method (no return)
  void randomX() {//Generates random x value
    randomX = random(width + 1);//Generate random number within width of screen
  }
  //Reset method (no return)
  void reset() {//Resets enemies
    this.randomX();//Generate random x value
    position.x = randomX;//Set position x to random x
    position.y = 0;//Set position y to 0
  }
  //Random fuel method (no return)
  void fuelRandom() {//Calculates if enemy should drop fuel 
    fuelProbability = int(random(5));//Generate random number between 0 and 4 (1/5 chance of drop)
    //If the number is 2:
    if(fuelProbability == 2) {
      drop = true;//Set drop to true
    //if the number is not 2:
    } else {
      drop = false;//Set drop to false
    }
  }
  
}
