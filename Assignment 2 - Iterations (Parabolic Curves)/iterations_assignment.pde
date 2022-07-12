//Declare position1, position2, x-axis translation, y-axis translation, and line spacing
int p2, p1, translateX, translateY, spacing;
//Declare light and dark colors
// Declare colors of line patterns 1, 2, 3, and 4
color light, dark, l1Color, l2Color, l3Color, l4Color;

//Create setup function
void setup() {
  //Create 600 x 600 run window
  size(600, 600);
  //Set background color to light beige
  background(#fcfff5);
  //Set light and dark colors
  light = color(#93ada0);
  dark = color(#1a3643);
  //Set line spacing to 20
  spacing = 20;
  //Set position 2 to middle of screen
  p2 = height/2;

  //Loop through line position in top half of screen (starting position)
  //p1 (position 1) will increment (upwards/forwards by 20)
  //p2 (position 2) will decrement (downwards/backwards by 20)
  for (p1 = 0; p1 < height/2; p1 += spacing) {
    //Decrement position 2 by 20
    p2 -= spacing;
    //Loop four times (four quadrants)
    for (int i = 0; i < 4; i++) {
      //In quadrant 1:
      if (i == 1) {
        //No translation of pattern (initial pattern starts at quadrant 1 located at top left)
        translateX = 0;
        translateY = 0;
        //Set color of all line patterns to light except for line pattern 3
        l4Color = l2Color = l1Color = light;
        l3Color = dark;

        //In quadrant 2:
      } else if (i == 2) {
        //Translate horizontally to center of screen
        translateX = width/2;
        //No vertical translation
        translateY = 0;

        //Set color of all line patterns to light except for line pattern 1
        l4Color = l3Color = l2Color = light;
        l1Color = dark;

        //In quadrant 3:
      } else if (i == 3) {
        //No horizontal translation
        translateX = 0;
        //Translate vertically to center of screen
        translateY = height/2;
        //Set color of all line patterns to light except for line pattern 2
        l4Color = l3Color = l1Color = light;
        l2Color = dark;

        //In quadrant 4:
      } else {
        //Translate horizontally to center of screen
        translateX = width/2;
        //Translate vertically to center of screen
        translateY = height/2;
        //Set color of all line patterns to light except for line pattern 4
        l3Color = l2Color = l1Color = light;
        l4Color = dark;
      }

      //Increment coordinates by translateX and translateY values to shift patern from quadrant 1 (top left) to other 3 quadrants after each iteration
      stroke(l1Color);
      //Bottom left corner (line pattern 1)
      line(0 + translateX, p1 + translateY, p1 + translateX, height/2 + translateY);

      stroke(l2Color);
      //Top right corner (line pattern 2)
      line(p1 + translateX, 0 + translateY, width/2 + translateX, p1 + translateY);

      stroke(l3Color);
      //Bottom right corner (line pattern 3)
      line(p1 + translateX, height/2 + translateY, width/2 + translateX, p2 + translateY);

      stroke(l4Color);
      //Top left corner (line pattern 4)
      line(p1 + translateX, 0 + translateY, 0 + translateX, p2 + translateY);
    }
  }
}
