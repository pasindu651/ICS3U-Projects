//Starfield class
class Starfield {
  Star [] backStar, frontStar, midStar;//Array of 3 layers of stars (foreground, midground, and background)

  //Starfield constructor
  Starfield() {
    backStar = new Star[15];//Create 15 spots in back star array
    midStar = new Star[15];//Create 15 spots in mid star array
    frontStar = new Star[15];//Create 15 spots in front star array

    this.createStars();//Call create stars method
  }
  //Create stars method (no return)
  void createStars() {//Iterates over arrays and creates star objects 
    for (int i = 0; i < frontStar.length; i++) {//Iterate over array
      backStar[i] = new Star(1, 10);//Create back star with speed 1 and size 10
      midStar[i] = new Star(2, 20);//Create new mid star with speed 2 and size 20
      frontStar[i] = new Star(6, 30);//Create new front star with speed 6 and size 30
    }
  }
  //Display method (no return)
  void display() {//Displays stars in each array with respect to parallax (order of layers)
    for (int i = 0; i < 3; i++) {//Loop three times
      for (int j = 0; j < frontStar.length; j++) {//Loop over arrays
        //Firstly (first layer):
        if (i == 0) {
          backStar[j].display();//Display back star 
        //Secondly (second layer):
        } else if (i == 1) {
          midStar[j].display();//Display mid star
        //Thirdly (third layer):
        } else if (i == 2) {
          frontStar[j].display();//Display front star
        }
      }
    }
  }
}
