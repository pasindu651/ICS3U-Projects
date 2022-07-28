//Boom class
class Boom {
  PImage explosion = loadImage("explosion.png");//Load explosion spritesheet
  int count, x, y;//x and y values of upper left corner of destination image
  int w;//width and height of destination image (copy)
  
  //Boom constructor
  Boom() {
    w = 384;//Set width to 384 (4608 / 12 total images)
    count = 0;//Set count to 0
  }
  //Display method (no return)
  void display(int x, int y) {//Displays each copy of spritesheet 
    //Loop over 6 images:
    for (int i = 0; i < 6; i++) {
      count++;//Increment count
      int sourceX = count * w;//Set x coordinate of source's upper left corner to count * width
      copy(explosion, sourceX, 0, w, w, x, y, w, w);//Copy selected part of image
      this.reset();//reset count 
    }
  }
  //Reset method (no return)
  void reset() {//Restarts sprite animation
    //If count has exceeds 6 images:
    if (count == 6) {
      count = 0;//Set count to 0
    }
  }
}
