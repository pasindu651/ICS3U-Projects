/*
GALACTIC WAR:
  Developed by Pasindu Danthanarayana
  ***PRESS ENTER TO SELECT MENU OPTIONS***
*/


//Import processing sound library
import processing.sound.*;

SoundFile background_music, hover, select, gunshot, explode, fuel, life_lost;

PImage startBG, ship_1, ship_2, ship_3, currentShip, one_heart, two_hearts,
  three_hearts, no_hearts, currentHearts;//Graphics

PFont titleFont;//Title font (Retro Gaming by Daymarius ** dafont.com)

color yellow, darkYellow, red, grey, startClr, instClr, quitClr, fuelClr;//Menu and fuel fext colors

int menuNum;//Current menu option number

int fuelAmount, fuelIncrement, fuelDecrement;//Fuel amount, decrement value, and icrement value

boolean shoot, collision, startPressed, howToPlay;//Boolean shoot, collision, start, and how to play screen

String howTo;//How to play instructions


//Objects (instances of classes)
Timer shootTimer;//Firing timer
Timer fuelUseTimer;//Fuel depletion timer
Menu gameMenu, overMenu;//Menu and game over menu
Player spaceship;//Player (spaceship)
Starfield space;//Starfield
Bullet projectile;//Projectile
Asteroid rock;//Asteroid
Enemy enemySpaceship;//Enemy (spaceship)
Fuel canister;//Fuel canister
Boom explosion;//Explosion

//Game state, next projectile, number of lives, and asteroid damage
int GAMESTATE, nextProjectile, lives, largeDamage, mediumDamage, smallDamage,

  //Enemy damage, total score, score achieved by shooting various asteroid sizes, and next fuel canister
  enemyDamage, score, smallScore, mediumScore, largeScore, nextCanister;

//Arrays of objects
Bullet [] projectiles;//Bullets
Asteroid [] asteroids;//Asteroids
Enemy [] enemies;//Enemies
Fuel [] canisters;//Fuel canisters

//Setup function (only called once at start of application)
void setup() {
  size(1200, 800);//Create 1200 x 800 run window
  frameRate(60);//Set fps to 60

  //Load sound files (for sfx)
  background_music = new SoundFile(this, "background_music.mp3");
  hover = new SoundFile(this, "hover.wav");
  select = new SoundFile(this, "select.wav");
  gunshot = new SoundFile(this, "gunshot.wav");
  explode = new SoundFile(this, "explosion.wav");
  fuel = new SoundFile(this, "fuel.wav");
  life_lost = new SoundFile(this, "life_lost.wav");

  //Loop background music
  background_music.loop();

  GAMESTATE = 1;//Set initial game state to 1
  menuNum = 1;//Set menu option number to 1

  titleFont = createFont("Retro Gaming", 128);//Create title font

  //Set colors for menu title
  yellow = #fbf934;
  darkYellow = #db8a03;
  red = #f50000;
  grey = #636363;

  //Load graphics
  startBG = loadImage("startBG.jpg");//Starting background

  ship_1 = loadImage("ship_1.png");//Spaceship (first state)
  ship_2 = loadImage("ship_2.png");//Spaceship (second state)
  ship_3 = loadImage("ship_3.png");//Spaceship (third state)

  no_hearts = loadImage("0_hearts.png");//No hearts remaining
  one_heart = loadImage("1_heart.png");//One heart remaining
  two_hearts = loadImage("2_hearts.png");//Two hearts remaining
  three_hearts = loadImage("3_hearts.png");//Three hearts remaining

  //How to play instructions
  howTo = "Use WASD to control the spaceship and spacebar to fire projectiles. Colliding with small asteroids inflict 1 heart of damage, medium asteroids inflict 2 hearts of damage, and large asteroids inflict 3 hearts of damage. The fuel supply will deplete by 10% for every 2 seconds. The game is lost if the fuel is fully depleted or if the spaceship is destroyed. Restore your fuel by collecting fuel canisters dropped by destroyed enemy spaceships. PRESS ENTER FOR MENU";

  //Create objects
  gameMenu = new Menu(titleFont, "START", "HOW TO PLAY", "QUIT", "GALACTIC WAR", true, yellow, darkYellow, red, grey);//New game menu with custom title, options, and colors
  overMenu = new Menu(titleFont, "RESTART", "HOW TO PLAY", "QUIT", "GAME OVER", false, yellow, darkYellow, red, grey);//New game over menu with custom title, options, and colors
  space = new Starfield();//New starfield
  spaceship = new Player(0, width/2, height/2);//New player
  projectiles = new Bullet[5];//Create 5 spots in projectiles array
  asteroids = new Asteroid[2];//Create 2 spots in asteroids array
  enemies = new Enemy[1];//Create 1 spot in enemies array
  canisters = new Fuel[5];//Create 5 spots in canisters array
  explosion = new Boom();//Create new boom

  //Iterate over arrays
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();//Create new asteroid
  }

  for (int i = 0; i < enemies.length; i++) {
    enemies[i] = new Enemy(120, 25);//Create new enemy with 120 size and 25 speed
  }

  for (int i = 0; i < canisters.length; i++) {
    canisters[i] = new Fuel(90, width*2, height*2);//Create new canisters with size 90, initially starting off screen
  }


  for (int i = 0; i < projectiles.length; i++) {
    projectiles[i] = new Bullet(50, 20, width*2, height*2);//Create new bullets with size 50, speed 20, initially starting off screen
  }

  //Set asteroid damage inflicted by various sizes
  largeDamage = 3;
  mediumDamage = 2;
  smallDamage = 1;

  enemyDamage = 2; //Set enemy damage

  //Set score achieved by destroying various sized asteroids
  smallScore = 50;
  mediumScore = 100;
  largeScore = 150;

  //Set fuel increment from collecting canisters and decrement inflicted every 2 seconds
  fuelIncrement = 20;
  fuelDecrement = 10;

  shootTimer = new Timer(500);//Set new shooting timer (limit) for 500 milliseconds
  fuelUseTimer = new Timer(5000);//Set timer for fuel canisters to disappear upon 5000 milliseconds after appearing (5 seconds)
}

//Draw function (called continuously)
void draw() {
  //If game state is 1 (menu):
  if (GAMESTATE == 1) {
    gameMenu.display();//Display game menu
    howToPlay();//Call how to play function
    //If game state is 2 (game):
  } else if (GAMESTATE == 2) {
    background(0);//Set background to black
    //If start is pressed:
    if (startPressed) {
      shootTimer.start();//Start shooting timer
      fuelUseTimer.start();//Start fuel use timer
      startPressed = false;//Set start pressed to false
    }
    space.display();//Display starfield
    spaceship.display(currentShip);//Display current spaceship state

    //If player is shooting and timer has finished:
    if (shoot && (shootTimer.finished())) {
      gunshot.play();//Play gunshot sfx
      projectiles[nextProjectile].fire(spaceship.position.x, spaceship.position.y - 30);//Fire projectile at current next projectile index and spaceship position
      nextProjectile = (nextProjectile+1) % projectiles.length;//Set next projectile to one after current projectile (resets after projectile index returns to 0)
      shootTimer.start();//Start shooting timer
    }
    //Loop over canisters array
    for (int l = 0; l < canisters.length; l++) {
      canisters[l].display();//Display current canister
      //If spaceship intersects current canister:
      if (fuel_playerCollision(canisters[l], spaceship)) {
        fuel.play();//Play collect fuel sfx
        fuelAmount += fuelIncrement;//Increment fuel amount
        canisters[l].reset();//Reset current canister
      }
    }

    //Loop over asteroids array
    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i].display();//Display current asteroid
      //If spaceship collides with asteroid:
      if (rock_playerCollision(asteroids[i], spaceship)) {
        //If asteroid is small sized:
        if (asteroids[i].size == 100) {
          lives -= smallDamage;//Inflict small damage
          //If asteroid is medium sized:
        } else if (asteroids[i].size == 150) {
          lives -= mediumDamage;//Inflict medium damage
          //If asteroid is large sized:
        } else if (asteroids[i].size == 200) {
          lives -= largeDamage;//Inflict large damage
        }
        explode.play();//Play explosion sfx
        life_lost.play();//Play life lost sfx
        explosion.display(int(asteroids[i].position.x - 180), int(asteroids[i].position.y - 180));//Display explosion at current asteroid position
        asteroids[i].reset();//Reset current asteroid
      }
    }
    //Loop over enemies array
    for (int i = 0; i < enemies.length; i++) {
      enemies[i].display();//Display current enemy
      enemies[i].fuelRandom();//Call random fuel method on current enemy
      //If enemy collides with spaceship:
      if (enemy_playerCollision(enemies[i], spaceship)) {
        explode.play();//Play explosion sfx
        life_lost.play();//Play life lost sfx
        lives -= enemyDamage;//Inflict enemy damage
        explosion.display(int(enemies[i].position.x - 180), int(enemies[i].position.y - 180));//Display explosion at current enemy position
        enemies[i].reset();//Reset current enemy
      }
    }
    //Iterate over projectiles array
    for (int i = 0; i < projectiles.length; i++) {
      projectiles[i].update();//Update current projectile
      //Iterate over asteroids array
      for (int j = 0; j < asteroids.length; j++) {
        //If current asteroid collides with current projectile:
        if (rock_bulletCollision(asteroids[j], projectiles[i])) {
          //If asteroid is small sized:
          if (asteroids[j].size == 100) {
            score += smallScore;//Add small score
            //If asteroid is medium sized:
          } else if (asteroids[j].size == 150) {
            score += mediumScore;//Add medium score
            //If asteroid is large sized:
          } else if (asteroids[j].size == 200) {
            score += largeScore;//Add large score
          }
          explode.play();//Play explosion sfx
          explosion.display(int(asteroids[j].position.x - 180), int(asteroids[j].position.y - 180));//Display explosion at current asteroid position
          asteroids[j].reset();//Reset current asteroid
          projectiles[i].reset();//Reset current projectile
        }
      }
      //Iterate over enemies array
      for (int  k = 0; k < enemies.length; k++) {
        //If bullet hits enemy:
        if (bullet_enemyCollision(enemies[k], projectiles[i])) {
          explode.play();//Play explode sfx
          explosion.display(int(enemies[k].position.x - 180), int(enemies[k].position.y - 180));//Display explosion at current enemy position
          //If enemy drops a fuel canister:
          if (enemies[k].drop) {
            canisters[nextCanister].drop(enemies[k].position.x, enemies[k].position.y);//Set canister position to current enemy position
            nextCanister = (nextCanister+1) % canisters.length;//Set net canister
          }
          enemies[k].reset();//Reset current enemy
          projectiles[i].reset();//Reset current projectile
        }
      }
      projectiles[i].display();//Display current projectile
    }

    checkLives();//Check number of remaining lives
    checkFuel();//Check remaining fuel and decrement

    //Display fuel amount
    textSize(50);
    fill(fuelClr);
    text("FUEL: " + fuelAmount + "%", width - 200, 100);

    //Display score
    textSize(50);
    fill(#ffffffff);
    text("SCORE: " + score, 200, 100);

    //If game state is 3 (game over):
  } else if (GAMESTATE == 3) {
    gameOver();//Call game over function
  }
}

//Check lives function (no return)
void checkLives() {//Checks remaining lives and display accordingly
  //If 1 life is remaining:
  if (lives == 1) {
    currentHearts = one_heart;//Display one heart
    //If 2 lives are remaining
  } else if (lives == 2) {
    currentHearts = two_hearts;//Display two hearts
    //If three lives are remaining:
  } else if (lives == 3) {
    currentHearts = three_hearts;//Display three hearts
    //If 0 lives or less are remaining:
  } else if (lives == 0 || lives < 0) {
    currentHearts = no_hearts;//Display no hearts
    GAMESTATE = 3;//Set game state to 3 (game over)
  }
  image(currentHearts, 200, 200, 150, 150);//Display number of hearts
}

//Check fuel function (no return)
void checkFuel() {//Checks amount of remaining fuel, displays in according color, and decrements fuel amount when timer finishes
  //If fuel timer finished:
  if (fuelUseTimer.finished()) {
    fuelAmount -= fuelDecrement;//Decrement fuel amount
    fuelUseTimer.start();//Start timer
  }
  //If remaining fuel is 25% or less:
  if (fuelAmount <= 25 ) {
    fuelClr = #f70000;//Display in red
    //If remaining fuel is between 25% and 50%:
  } else if (fuelAmount > 25 && fuelAmount <= 50) {
    fuelClr = #fe0a2e;//Display in orange
    //If remaining fuel is between 50% and 75%:
  } else if (fuelAmount > 50 && fuelAmount <= 75) {
    fuelClr = #e6fe36;//Display in yellow
    //If remaining fuel is between 75% and 100%:
  } else if (fuelAmount > 75 && fuelAmount <= 100) {
    fuelClr = #20b300;//Display in green
  }
  //If remaining fuel is 0%:
  if (fuelAmount == 0) {
    lives = 0;//Set lives to 0
  }
}

//Create collision detection functions

//Rock and projectile collision detection function (boolean return)
boolean rock_bulletCollision(Asteroid rock, Bullet projectile) {//Returns true if given asteroid and bullet objects intersect
  float distance = dist(rock.position.x, rock.position.y, projectile.position.x, projectile.position.y);//Check distance between two objects
  //If distance is within asteroid diameter:
  if (distance < (rock.size)) {
    return true;//Return true
    //If distance outside diameter:
  } else {
    return false;//Return false
  }
}

//Rock and player collision detection function (boolean return)
boolean rock_playerCollision(Asteroid rock, Player spaceship) {//Returns true if given asteroid and player objects intersect
  float distance = dist(rock.position.x, rock.position.y, spaceship.position.x, spaceship.position.y);//Check distance between two objects
  //If distance is within asteroid diameter:
  if (distance < (rock.size)) {
    return true;//Return true
    //If distance outside diameter:
  } else {
    return false;//Return false
  }
}
//Bullet and enemy collision detection function (boolean return)
boolean bullet_enemyCollision(Enemy enemySpaceship, Bullet projectile) {//Returns true if given enemy and bullet objects intersect
  float distance = dist(projectile.position.x, projectile.position.y, enemySpaceship.position.x, enemySpaceship.position.y);//Check distance between two objects
  //If distance is within enemy spaceship height:
  if (distance < (enemySpaceship.size)) {
    return true;//Return true
    //If distance is outside enemy spaceship height:
  } else {
    return false;//Return false
  }
}
//Enemy and player collision detection function (boolean return)
boolean enemy_playerCollision(Enemy enemySpaceship, Player spaceship) {//Returns true if given enemy and player objects intersect
  float distance = dist(enemySpaceship.position.x, enemySpaceship.position.y, spaceship.position.x, spaceship.position.y);//Check distance between two objects
  //If distance is within enemy spaceship height:
  if (distance < (enemySpaceship.size)) {
    return true;//Return true
    //If distance is outside enemy spaceship height:
  } else {
    return false;//Return false
  }
}
//Fuel and player collision detection function (boolean return)
boolean fuel_playerCollision(Fuel canister, Player spaceship) {//Returns true if fuel and player objects intersect
  float distance = dist(canister.position.x, canister.position.y, spaceship.position.x, spaceship.position.y);//Check distance between two objects
  //If distance is within canister height:
  if (distance < (canister.size)) {
    return true;//Return true
    //If distance is outside canister height:
  } else {
    return false;//Return false
  }
}
//Game over function (no return)
void gameOver() {//Handles game over functions
  overMenu.display();//Display game over menu
  howToPlay();//Check if user clicks how to play
}
//Start game function (no return)
void startGame() {//Sets all prerequisite values for game
  currentHearts = three_hearts;//Set current hearts to 3
  currentShip = ship_1;//Set current ship state to 1
  lives = 3;//Set starting lives to 3
  nextProjectile = 0;//Set next projectile index to 0
  nextCanister = 0;//Set next canister index to 0
  score = 0;//Set starting score to 0
  fuelAmount = 100;//Set starting fuel amount to 100

  shoot = false;//Set shoot to false
  startPressed = false;//Set start pressed to false
  howToPlay = false;//Set how to play to false;
}

//How to play function (no return)
void howToPlay() {//Checks if user clicks on or off how to play
  //If how to play is true:
  if (howToPlay) {
    //Display instructions on black background
    fill(0);
    rect(0, 0, width, height);
    textSize(20);
    fill(#ffffffff);
    textAlign(CENTER);
    text(howTo, 0, 100, width, height);
  }
}


//Menu options handler function (no return)
void menuOptionsHandler(Menu gameMenu) {//Given menu object, calls appropriate functions depending on menu option clicked
  //If down is clicked:
  if (keyCode == DOWN) {
    gameMenu.menuNum++;//Increment menu number
    hover.play();//Play hover sfx
  //If up is clicked:
  } else if (keyCode == UP) {
    gameMenu.menuNum--;//Decrement menu number
    hover.play();//Play hover sfx
  }
  //If third option (exit) is clicked:
  if (gameMenu.menuNum == 3 && keyCode == ENTER) {
    select.play();//Play select sfx
    exit();//Exit application
  //If how to play is false and is clicked:
  } else if ((!howToPlay) && gameMenu.menuNum == 2 && keyCode == ENTER) {
    howToPlay = true;//Set how to play to true
    select.play();//Play select sfx
  //If how to play is true and is clicked:
  } else if ((howToPlay) && keyCode == ENTER) {
    howToPlay = false;//Set how to play to false
    select.play();//Play select sfx
   //If first option (start/restart) game is clicked:
  } else if (gameMenu.menuNum == 1 && keyCode == ENTER) {
    select.play();//Play select sfx
    GAMESTATE = 2;//Set game state to 2 (start)
    startGame();//Start game
    startPressed = true;//Set start pressed to true
  }
}

//Key pressed function (called every time key is pressed)
void keyPressed() {
  //If game state is 1 (menu):
  if (GAMESTATE == 1) {
    menuOptionsHandler(gameMenu);//Call menu options handler function (start menu)
  //If game state is 2 (start):
  } else if (GAMESTATE == 2) {
    //If left is clicked:
    if (keyCode == LEFT) {
      spaceship.moveLeft();//Move spaceship left
      currentShip = ship_2;//Set current ship state to 2
    //If right is clicked:
    } else if (keyCode == RIGHT) {
      spaceship.moveRight();//Move spaceship right
      currentShip = ship_3;//Set current ship state to 3
    //If up is clicked:
    } else if (keyCode == UP) {
      spaceship.moveUp();//Move spaceship up
    //If down is clicked:
    } else if (keyCode == DOWN) {
      spaceship.moveDown();//Move ship down
    //If spacebar is clicked:
    } else if (keyCode == 32) {
      shoot = true;//Set shoot to true
    }
  //If game state is 3 (game over)
  } else if (GAMESTATE == 3) {
    menuOptionsHandler(overMenu);//Call menu options handler function (game over)
  }
}

//Key released function (called every time key is released)
void keyReleased() {
  //If left or right is released:
  if (keyCode == LEFT || keyCode == RIGHT) {
    spaceship.stopX();//Stop horizontal spaceship movement
    currentShip = ship_1;//Set current ship state to 1
  //If up or down is released:
  } else if (keyCode == UP || keyCode == DOWN) {
    spaceship.stopY();//Stop vertical spaceship movement
  //If spacebar is released:
  } else if (keyCode == 32) {
    shoot = false;//Set shoot to false
  }
}
