//Fuel class
class Fuel {
  PImage fuel;//Fuel canister graphics
  int size;//Size
  float sx, sy, x, y;//Starting x, starting y, x, and y
  PVector position, starting_position;//Position and starting position vectors
  Timer fuelTimer;//Fuel timer

  //Fuel constructor
  Fuel(int size, float sx, float sy) {
    position = new PVector(x, y);//Set position to x and y 
    starting_position =  new PVector(sx, sy);//Set starting position to sx and sy
    this.size = size;
    fuel = loadImage("fuel.png");//Load fuel graphics
    fuelTimer = new Timer(2000);//Set fuel timer to 2000 (will diseappear after 2 seconds upon appearing)
  }
  //Display method (no return)
  void display() {//Displays fuel canisters
    image(fuel, position.x, position.y, this.size, this.size);//Draw canisters
    //If timer finished:
    if(fuelTimer.finished()) {
      this.reset();//Reset position
    }
  }
  //Drop method (no return)
  void drop(float enemyX, float enemyY) {//Drops canister at enemy position when ready
    fuelTimer.start();//Start fuel timer
    position.x = enemyX;//Set position x to enemy position 
    position.y = enemyY;//Set position y to enemy position
  }
  
  //Reset method (no return)
  void reset() {
    position.x = starting_position.x;//Set position x to starting position
    position.y = starting_position.y;//Set position y to starting position
  }
}
