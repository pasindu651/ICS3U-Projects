//Asteroid class
class Asteroid {
  int speed, size;//Speed and size
  PVector position, velocity;//Position and velocity vectors
  int randomNum;//Random number
  float randomX;//Random x value
  PImage small_rock, medium_rock, large_rock, rock;//Graphics of small, medium, and large asteroids
  boolean collision;//Boolean collision

  //Asteroid Constructor
  Asteroid() {
    collision = false;//Set collision to false
    
    //Load graphics
    small_rock = loadImage("small_rock.png");
    medium_rock = loadImage("medium_rock.png");
    large_rock = loadImage("large_rock.png");
    
    this.randomNum();//Call random number method
    
    position = new PVector(randomX, 0);//Set position to random x value and 0
    velocity = new PVector(0, speed);//Set velocity to 0 and speed
  }
  //Random number method (no return)
  void randomNum() {//Generates random rock size and speed
    randomNum = int(random(3));//Generate random number between 0 and 2
    //If number is 0:
    if (randomNum == 0) {
      rock = small_rock;//Set rock to small rock image
      size = 100;//Set size to 100
      speed = 15;//Set speed to 15
    //If random number is 1:
    } else if (randomNum == 1) {
      rock = medium_rock;//Set rock to medium rock image
      size = 150;//Set size to 150
      speed = 10;//Set speed to 10
    //If random number is 2:
    } else if (randomNum == 2) {
      rock = large_rock;//Set rock to large rock image
      size = 200;//Set size to 200
      speed = 5;//Set speed to 5
    }
  }

  //Display method (no return)
  void display() {//Displays asteroids
    //If asteroid exceeds screen height:
    if (position.y - size > height) {
      this.reset();//Reset asteroid
    }
    position.add(velocity);//Add velocity to position
    //Draw asteroid image
    imageMode(CENTER);
    image(rock, position.x, position.y, size, size);
    fill(#D11960);
  }
  //Reset method (no return)
  void reset() {//Resets image and position of asteroid
    this.randomNum();//Generate random number
    randomX = random(width + 1);//Set random x value to random number within width of screen
    position.x = randomX;//Set position x to random x value
    position.y = 0;//Set position y to 0
  }
}
