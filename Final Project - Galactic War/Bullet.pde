//Bullet class
class Bullet {
  PImage bullet;//Bullet image
  PVector position, velocity, starting_position;//Position, velocity, and starting position vectors
  float sx, sy, speed, size;//Starting x and y, speed, and size

  //Bullet constructor
  Bullet(float size, float speed, float sx, float sy) {
    this.sx = sx;
    this.sy = sy;
    this.size = size;
    this.speed = speed;
    bullet = loadImage("bullet.png");//load bullet graphics
    starting_position = new PVector(sx, sy);//Set starting position
    position = new PVector((spaceship.position.x), (spaceship.position.y - 40));//Set position to current spaceship position
    velocity = new PVector(0, this.speed);//Set velocity to 0 and speed
    shoot = false;//Set shoot to false
  }
  //Update method (no return)
  void update() {//Updates position of projectile
    position.sub(velocity);//Subtract velocity from position (travels upwards)
    this.offScreen();//Call off screen method
  }

  //Display method (no return)
  void display() {//displays bullet graphics
    imageMode(CENTER);
    image(bullet, position.x, position.y, this.size, this.size);//Draw bullet
  }
  //Reset method (no return)
  void reset() {//Resets projectile after used
    position.x = starting_position.x;//Set position x to starting position
    position.y = starting_position.y;//Set position y to starting position
    this.speed = 0;//Set initial speed to 0
  }
  //Fire method (no return)
  void fire(float playerX, float playerY) {//Fires bullet at player position when ready
    position.x = playerX;//Set position x to player position 
    position.y = playerY;//Set position y to player position 
    this.speed = 20;//Set speed to 20
  }

  //Off screen method (no return)
  void offScreen() {//Checks if projectile exceeds screen boundaries
    //If projectile goes off screen:
    if (position.x < 0 || position.x > width || position.y < 0 || position.y > height) {
      this.reset();//Reset projectile
    }
  }
}
