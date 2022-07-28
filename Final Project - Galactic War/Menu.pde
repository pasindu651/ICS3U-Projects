//Menu class
class Menu {
  PFont font;//Menu font
  PImage startBG;//Start background
  int menuNum;//Menu number
  color startClr, instClr, quitClr, yellow, darkYellow, red, grey;//Colors
  String menu1, menu2, menu3, title;//Menu options and title
  Boolean bg;//Boolean background (yes for start menu, no for game over menu)

  //Menu constructor
  Menu(PFont font, String menu1, String menu2, String menu3, String title, Boolean bg, color yellow, color darkYellow, color red, color grey) {//Creates menu
    this.font = font;
    this.yellow = yellow;
    this.darkYellow  = darkYellow;
    this.red = red;
    this.grey = grey;
    this.menu1 = menu1;
    this.menu2 = menu2;
    this.menu3 = menu3;
    this.title = title;
    this.bg = bg;
    menuNum = 1;//Set initial menu number to 1
    startBG = loadImage("startBG.jpg");//Load background
  }
  //Display method (no return)
  void display() {//Displays menu
    //If background is true:
    if (this.bg) {
      image(startBG, 0, 0, width, height);//Draw background
    }
    textFont(this.font);
    textAlign(CENTER, BOTTOM);

    textSize(100);
    fill(this.red);
    text(this.title, width/2 + 10, height/2);//Red title layer

    fill(this.yellow);
    text(this.title, width/2, height/2);//Yellow title layer
    //If menu number is 1:
    if (menuNum == 1) {
      startClr = color(255);//Set start color to white
      //Set rest to grey
      instClr = this.grey;
      quitClr = this.grey;
    //If menu number is 2:
    } else if (menuNum == 2) {
      instClr = color(255);//Set inst color to white
      //Set rest to grey
      startClr = this.grey;
      quitClr = this.grey;
    //If menu number is 3;
    } else {
      quitClr = color(255);//Set quit color to white
      //Set rest to grey
      startClr = this.grey;
      instClr = this.grey;
    }

    this.offScreen();//Call off screen method

    textSize(50);
    fill(startClr);
    text(this.menu1, width/2, height/2 + 80);//Menu option 1
    fill(instClr);
    text(this.menu2, width/2, height/2 + 150);//Menu option 2
    fill(quitClr);
    text(this.menu3, width/2, height/2 + 220);//Menu option 3
  }

  //Off screen method (no return)
  void offScreen() {//Checks if user clicks down after last option or up before first option
    //If menu number is greater than 3 (below):
    if (menuNum > 3) {
      menuNum = 1;//Set menu number to 1
    //If menu number is less than one (above):
    } else if (menuNum < 1) {
      menuNum = 3;//Set menu number to 3
    }
  }
}
