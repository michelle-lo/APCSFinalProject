import processing.sound.*;
import java.util.*;
SoundFile file;
String audioName = "shortGame.mp3";
String path;

PImage backgroundImage;
PImage catCharacter;
PImage galaxyCat;
Protaganist cat; 
Enemy whiskers;
PImage doodleicon;
PImage help;
PImage textbox;
PImage panel;
PImage propane;
PImage antennae;
PImage spaceship;
static int health = 15;

//coordinates of line drawn by player
float xi;
float yi;
float xf;
float yf;
float xf2;
float yf2;
float[] linePts = new float[4]; 
float[] linePts2 = new float[6];
int symb;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean alrPressed = false;
boolean notLine = false;
int totalDead = -5;
boolean isDisabled = true;
boolean isHelp = false;
int scene = 0;
boolean stage1 = false;
boolean stage2 = false;
boolean stage3 = false;
boolean toggleN = true;


//setup() loads the background and creates the protaganist object.
void setup() {
  size(1000, 800);
  backgroundImage = loadImage("space.jpg");
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
  catCharacter = loadImage("croppedNyanCat.png");
  galaxyCat = loadImage("croppedGalaxyCat.png");
  doodleicon = loadImage("doodleicon.png");
  textbox = loadImage("textbox.png");
  help = loadImage("Help.png");
  panel = loadImage("panel.png");
  propane = loadImage("propane.png");
  antennae = loadImage("antennae.png");
  spaceship = loadImage("spaceship.png");
  imageMode(CENTER);
  image(backgroundImage, 0, 0);
  backgroundImage.resize(1000, 800);
  image(backgroundImage, 0, 0);
  backgroundImage.loadPixels();
  cat = new Protaganist();
  whiskers = new Enemy(width / 2 + 250, height / 2, 0, 0, 0);
  symb = -1; //-1 indicates no symbol
}

void draw() {
  background(backgroundImage); 
  text("scene: " + scene, 20, 80);
  //homescreen

  if (totalDead == -5) {
    homeScreen();
  } else if (totalDead == -4) { //intro cut scene  
    textAlign(LEFT);
    //image(textbox, width / 2, height - textbox.height + 50, textbox.width + 150, textbox.height + 50);
    textSize(20);
    cutscene();
    //} else if (totalDead == -3) {
  } else {
    textAlign(LEFT);
    textSize(25);
    text("Lives Left: " + health, 20, 40); 
    text("Total Dead: " + totalDead, 20, 60);
    cat.display();
    enemyDisplay();
    drawLine();
    endScreen();
    //winScenario();
  }

  //stage 1
  if (stage1 && totalDead < 10 && totalDead >= 0) { //total number of enemies needed to be defeated before advancing is 10
    text("STAGE 1", width/2, 40);
    float upper = 2; //this is the upper bound for the velocity 
    float lower = -1; //this is the lower bound for the velocity
    float maxPatternLen = 3; //this is the max pattern length 
    //at the start, spawn 2 enemies
    if ((totalDead == 0) && (enemies.size() == 0)) {
      spawn(2, upper, lower, maxPatternLen);
    }

    if (totalDead < 9 && enemies.size() < 2) { 
      spawn(1, upper, lower, maxPatternLen);
    }
  }

  if (stage2 == false && totalDead == 10) {
    textSize(20);
    if (scene == 15) {
      scene++;
    }
    cutscene();
  }

  //stage 2
  if (stage2 && totalDead >= 10 && totalDead < 20) { //feel free to adjust the numbers 
    text("STAGE 2", width/2, 40);
    float upper = 2.5;
    float lower = -1;
    float maxPatternLen = 4;
    if ((totalDead == 10) && (enemies.size() == 0)) {
      spawn(2, upper, lower, maxPatternLen);
    }
    if (totalDead < 19 && enemies.size() < 2) { 
      spawn(1, upper, lower, maxPatternLen);
    }
  } 

  if (stage3 == false && totalDead == 20) {
    textSize(20);
    if (scene == 22) {
      scene++;
    }
    cutscene();
  }

  //stage 3
  if (stage3 && totalDead >= 20 && totalDead < 30) {
    text("STAGE 3", width/2, 40);
    float upper = 2.5;
    float lower = -1;
    float maxPatternLen = 5;
    if ((totalDead == 20) && (enemies.size() == 0)) {
      spawn(2, upper, lower, maxPatternLen);
    }
    if (totalDead < 29 && enemies.size() < 2) { 
      spawn(1, upper, lower, maxPatternLen);
    }
  }

  if (totalDead == 30) {
    textSize(20);
    if (scene == 30) {
      scene++;
    }
    cutscene();
  }
}

//player can draw lines anywhere on the screen
void drawLine() {
  if (mousePressed && mouseButton == LEFT && keyPressed && keyCode == 16) { 
    stroke(225);
    strokeWeight(10);
    line(xi, yi, xf, yf);
  } else if (keyPressed && keyCode == 16 && alrPressed == true && mousePressed == false) {
    line(xi, yi, xf, yf);  
    line(xf, yf, xf2, yf2);
  } else if (mousePressed && mouseButton == LEFT) {
    stroke(225);
    strokeWeight(10);
    line(xi, yi, xf, yf);
  } else {
    xi = mouseX;
    yi = mouseY;
    xf = mouseX;
    yf = mouseY;
    xf2 = mouseX;
    yf2 = mouseY;
  }
}

//displays all enemies unless dead
void enemyDisplay() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).move();
    if (! enemies.get(i).isDead()) {
      enemies.get(i).display();
    } else {
      totalDead++;
      enemies.remove(i);
    }
  }
}

//switches to lose background scenario 
void endScreen() {
  if (health <= 0) {
    size(1000, 800);
    backgroundImage = loadImage("croppedGameOver.jpg");
    backgroundImage.resize(1000, 800);
    backgroundImage.loadPixels();
    background(backgroundImage);
  }
}

void winScenario() {
  size(1000, 800);
  backgroundImage = loadImage("winGameScreen.jpg");
  backgroundImage.resize(1000, 800);
  backgroundImage.loadPixels();
  background(backgroundImage);
}

void pinkBackground(){
  size(1000, 800);
  backgroundImage = loadImage("pinkGalaxy.jpg");
  backgroundImage.resize(1000, 800);
  backgroundImage.loadPixels();
  background(backgroundImage);
}

void blueBackground(){
  size(1000, 800);
  backgroundImage = loadImage("blueGalaxy.jpg");
  backgroundImage.resize(1000, 800);
  backgroundImage.loadPixels();
  background(backgroundImage);
}

void greenBackground(){
  size(1000, 800);
  backgroundImage = loadImage("greenGalaxy.jpg");
  backgroundImage.resize(1000, 800);
  backgroundImage.loadPixels();
  background(backgroundImage);
}

//spawn() spawns number of enemies randomly on the sides of the screen. 
void spawn(int numEnemies, float upperV, float lowerV, float maxPatternLen) {
  //int numEnemies = 10;
  for (int i = 0; i < numEnemies; i++) {
    float chance = (int) (Math.random() * 4) + 1;
    float enemyX = 0;
    float enemyY = 0;
    if (chance == 1) { //top
      enemyX = (float) Math.random() * (width + 1); 
      enemyY = 0;
    } else if (chance == 2) { //bottom
      enemyX = (float) Math.random() * (width + 1); 
      enemyY = height;
    } else if (chance == 3) { //left
      enemyX = 0;
      enemyY = (float) Math.random() * (height + 1);
    } else {
      enemyX = width;
      enemyY = (float) Math.random() * (height + 1);
    }
    Enemy e = new Enemy(enemyX, enemyY, upperV, lowerV, maxPatternLen);
    enemies.add(e);
  }
}


//mouseDragged() changes the end point coordinates of the line when the mouse is moving
void mouseDragged() { 
  if (mouseButton == LEFT) {
    xf = mouseX;
    yf = mouseY;
  }
}

//mouseMoved() changes the end points of the second line created for the carrot symbols when mouse is moving (but not held down)
void mouseMoved() {
  if (keyCode == 16) {
    xf2 = mouseX;
    yf2 = mouseY;
  }
}

//mousePressed() records the initial coordinates of every new line
void mousePressed() {
  if (mouseButton == LEFT) {
    xi = mouseX;
    yi = mouseY;
    stroke(10);
    println("xi: " + xi + " yi: " + yi);
  }
}

//mouseReleased() records the final coordinates of the line once mouse is released
void mouseReleased() {
  if (mouseButton == LEFT && keyPressed && keyCode == 16) { //mouse is released
    xf = mouseX;  //meaning that first line is created but second hasn't
    yf = mouseY;
    linePts2[0] = xi;
    linePts2[1] = yi;
    linePts2[2] = xf;
    linePts2[3] = yf;
    alrPressed = true;
  } else if (mouseButton == LEFT) {
    stroke(0);
    xf = mouseX;
    yf = mouseY;
    println("xf: " + xf + " yf: " + yf);
    linePts[0] = xi;
    linePts[1] = yi;
    linePts[2] = xf;
    linePts[3] = yf;
    symbolize();
    for (int i = 0; i < enemies.size(); i++) {
      enemies.get(i).getAttacked(symb);
    }
    symb = -1;
  } else { //creates new enemy at mouse location (for testing purposes)
    Enemy test = new Enemy(mouseX, mouseY, 3, -3, 7);
    enemies.add(test);
  }
}

//symbolize() recognizes the symbol based on the slope of the line created.
void symbolize() {
  String test = "len1: ";
  if (! notLine) {
    float len = dist(linePts[0], linePts[1], linePts[2], linePts[3]);
    test += len;
    if (len >= 50) {
      float slope = (linePts[3] - linePts[1]) / (linePts[2] - linePts[0]);
      test += " slope: " + slope;
      if (abs(slope) >= 5) {
        println(test += " 0 (up)");
        symb = 0;
      } else if (abs(slope) <= 0.15) {
        println(test += " 1 (horizontal)");
        symb = 1;
      } else if (slope <= -0.7 && slope >= -3.15) {
        println(test += " 2 (positive slope)");
        symb = 2;
      } else if (slope >= 0.7 && slope <= 3.15) {
        println(test += " 3 (negative slope)");
        symb = 3;
      } else {
        println(test += " Not valid symbol");
        symb = -1;
      }
    } else {
      println(test += " too short.");
      symb = -1;
    }
  } else {
    float len1 = dist(linePts2[0], linePts2[1], linePts2[2], linePts2[3]);
    float len2 = dist(linePts2[2], linePts2[3], linePts2[4], linePts2[5]);
    test += len1 + " len2: " + len2;
    if (len1 >= 50 && len2 >= 50) {
      float slope1 = (linePts2[3] - linePts2[1]) / (linePts2[2] - linePts2[0]);
      float slope2 = (linePts2[5] - linePts2[3]) / (linePts2[4] - linePts2[2]);
      if (slope1 <= -0.7 && slope1 >= -3.15) { //slope is positive
        if (linePts2[0] > linePts2[2]) { //positive slope going down
          if (slope2 >= 0.7 && slope2 <= 3.15) { //negative slope
            println(test += " 4 (\\/) --> 2");
            symb = 4;
          } else {
            println(test += " Not valid symbol");
            symb = -1;
          }
        } else { //positive slope going up
          if (slope2 >= 0.7 && slope2 <= 3.15) { //negative slope
            println(test += " 5 (/\\) --> 3");
            symb = 5;
          } else {
            println(test += " Not valid symbol");
            symb = -1;
          }
        }
      } else if (slope1 >= 0.7 && slope1 <= 3.15) { //negative slope
        if (linePts2[0] < linePts2[2]) { //negative slope going downwards
          if (slope2 <= -0.7 && slope2 >= -3.15) { //positive slope
            println(test += " 4 (\\/) --> 1");
            symb = 4;
          } else {
            println(test += " Not valid symbol");
            symb = -1;
          }
        } else { //negative slope going upwards
          if (slope2 <= -0.7 && slope1 >= -3.15) { //positive slope
            println(test += " 5 (/\\) --> 4");
            symb = 5;
          } else {
            println(test += " Not valid symbol");
            symb = -1;
          }
        }
      } else {
        println(test += " Not valid symbol");
        symb = -1;
      }
    } else {
      println(test += " Not valid symbol");
    }
  }
  notLine = false;
}


void keyReleased() {
  if (keyCode == 16) {
    xf2 = mouseX;
    yf2 = mouseY;
    if (xf2 != xf && yf2 != yf) {
      linePts2[4] = xf2;
      linePts2[5] = yf2;
      alrPressed = false;
      println(Arrays.toString(linePts2));
      notLine = true;
      symbolize();
      for (int i = 0; i < enemies.size(); i++) {
        enemies.get(i).getAttacked(symb);
      }
      symb = -1;
    }
  }
}

//reduces number of lives when protaganist is touched by an enemy
static void getAttacked() {
  health--;
}

void homeScreen() {
  image(doodleicon, width / 2 - 200, height / 2, 500, 500);
  noStroke();
  fill(4, 92, 90);
  rect(width / 2 + 100, height / 2 - 130, 250, 100); //play
  rect(width / 2 + 100, height / 2, 250, 100); //help
  textAlign(CENTER);
  fill(225);
  textSize(20);
  text("PLAY", (width / 2 + 100) + (250.0 / 2), (height / 2 - 130) + (100.0 / 2)); 
  text("HELP", (width / 2 + 100) + (250.0 / 2), (height / 2) + (100.0 / 2)); 

  if (! isHelp && mousePressed && mouseButton == LEFT && 
    (mouseX <= width / 2 + 100 + 250 && mouseX >= width / 2 + 100) &&
    (mouseY <= height / 2 - 130 + 100 && mouseY >= height / 2 - 130)) {
    totalDead = -4;
    isDisabled = false;
  } 
  if (mousePressed && mouseButton == LEFT && 
    (mouseX <= width / 2 + 100 + 250 && mouseX >= width / 2 + 100) &&
    (mouseY <= height / 2 + 100 && mouseY >= height / 2)) {
    isHelp = true;
  } 

  if (isHelp) {
    fill(225, 0, 0);
    rect(width - 150, height - 50, 150, 50);
    fill(225);
    text("EXIT", width - 75, height - 25);
    image(help, width / 2, height / 2, 700, 700); 
    if (mousePressed && mouseButton == LEFT &&
      mouseX <= width && mouseX >= width - 150 &&
      mouseY <= height && mouseY >= height - 50) {
      isHelp = false;
    }
  }
}

void cutscene() {
  //the next cutscene will play when the player presses the "n" key
  if (scene != 44) {
    image(textbox, width / 2, height - textbox.height + 50, textbox.width + 150, textbox.height + 50);
  }
  if (scene == 0) {
    //text("On one fine day in the Calactic universe, Luna, a Space Castronaut,"
    //anything longer than the line above would be problematic...
    cat.display();
    image(spaceship, 300, 300, 300, 200);
    text("On one fine day in the Calactic universe, Luna, a Space Castronaut,", 160, 600);
    text("gets ready to go home after a busy day at Meowvesant.", 160, 630);
  } else if (scene == 1) {
    cat.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: I can’t believe finals week is finally over!", 160, 600);
  } else if (scene == 2) {
    cat.display();
    image(spaceship, 300, 300, 300, 200);
    text("Goodbye sleepless nights and hello Summer va-cat-ion!", 160, 600);
    text("I can’t wait to kick back at home.", 160, 630);
  } else if (scene == 3) {
    cat.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna boards her Catillac, her personalized space shuttle, and", 160, 600);
    text("begins her journey across the Calactic Universe.", 160, 630);
  } else if (scene == 4) {
    cat.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: (singing) Nyan Nyan Nyan Nyan~ ", 160, 600);
  } else if (scene == 5) {
    cat.display();
    text("*BOOM*", 160, 600);
  } else if (scene == 6) {
    cat.display();
    text("Luna: Huh?! What just happened?!", 160, 600);
  } else if (scene == 7) {
    cat.display();
    text("Luna begins to investigate", 160, 600);
  } else if (scene == 8) {
    cat.display();
    whiskers.display();
    text("Whiskers: Look what you have done!", 160, 600);
  } else if (scene == 9) {
    cat.display();
    whiskers.display();
    text("A strange creature appears behind Luna", 160, 600);
  } else if (scene == 10) {
    cat.display();
    whiskers.display();
    text("Luna: W-who are you?", 160, 600);
  } else if (scene == 11) {
    cat.display();
    whiskers.display();
    text("Whiskers: I'm Whiskers, a Bug, and your stupid flying thing", 160, 600);
    text("just trespassed into my territory!", 160, 630);
  } else if (scene == 12) {
    cat.display();
    whiskers.display();
    text("Luna: Oh no! My Catillac is all broken now!", 160, 600);
  } else if (scene == 13) {
    cat.display();
    whiskers.display();
    text("Whiskers: You have no remorse for your actions! You and your", 160, 600);
    text("ship must now suffer the consequences! Bugs - assemble!", 160, 630);
  } else if (scene == 14) {
    cat.display();
    whiskers.display();
    text("Luna: Ny-o!!!", 160, 600);
  } else if (scene == 15) { //the first line of "after intro" scene 
    pinkBackground();
    //scene++;
    toggleN = false;
    stage1 = true;
    totalDead = 0;
  } else if (scene == 16) {
    toggleN = true;
    cat.display();
    whiskers.display();
    text("Whiskers: You have defeated my army of bugs!", 160, 600);
  } else if (scene == 17) {
    cat.display();
    whiskers.display();
    text("Luna: I have to go home to my family!", 160, 600);
  } else if (scene == 18) {
    cat.display();
    whiskers.display();
    image(panel, 300, 300, 200, 100);
    text("Whiskers: Here is your control panel.", 160, 600);
  } else if (scene == 19) {
    cat.display();
    whiskers.display();
    image(panel, 300, 300, 200, 100);
    text("You obtained: Panel", 160, 600);
  } else if (scene == 20) {
    cat.display();
    whiskers.display();
    image(panel, 300, 300, 200, 100);
    text("Luna: Thank you!", 160, 600);
  } else if (scene == 21) {
    //toggleN = true;
    cat.display();
    whiskers.display();
    image(panel, 300, 300, 200, 100);
    text("Whiskers: Don’t thank me yet, you still have to learn your lesson", 160, 600);
  } else if (scene == 22) { //last line of "after stage 1" scene
    //scene++;
    blueBackground();
    toggleN = false;
    stage2 = true; //start stage 2
  } else if (scene == 23) {
    toggleN = true;
    cat.display();
    whiskers.display();
    text("Luna: Haha! I'm getting good at this!", 160, 600);
  } else if (scene == 24) {
    cat.display();
    whiskers.display();
    text("Whiskers: You got to be kitten me!", 160, 600);
  } else if (scene == 25) {
    cat.display();
    whiskers.display();
    image(antennae, 300, 300, 100, 200);
    text("Whiskers: Whatever! Here's your antenna...", 160, 600);
  } else if (scene == 26) {
    cat.display();
    whiskers.display();
    image(antennae, 300, 300, 100, 200);
    text("You obtained: antenna", 160, 600);
  } else if (scene == 27) {
    cat.display();
    whiskers.display();
    image(antennae, 300, 300, 100, 200);
    text("Luna: Yes! Purr-fect!", 160, 600);
  } else if (scene == 28) {
    cat.display();
    whiskers.display();
    image(antennae, 300, 300, 100, 200);
    text("Whiskers: You're not done with me yet...", 160, 600);
  } else if (scene == 29) {  
    toggleN = true;
    cat.display();
    whiskers.display();
    image(antennae, 300, 300, 100, 200);
    text("You still have to face the wrath of the More-Difficult-Stage-3!", 160, 600);
  } else if (scene == 30) {
    //scene++;
    greenBackground();
    toggleN = false;
    stage3 = true; //start stage 3
  } else if (scene == 31) {
    toggleN = true;
    cat.display();
    whiskers.display();
    image(propane, 300, 300, 180, 240);
    text("You obtained: Propane", 160, 600);
  } else if (scene == 32) {
    cat.display();
    whiskers.display();
    image(propane, 300, 300, 180, 240);
    text("Luna: Yes! Claw-some!", 160, 600);
  } else if (scene == 33) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna's Catillac makes an appearance", 160, 600);
  } else if (scene == 34) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Whiskers: You defeated me and all of my friends!", 160, 600);
  } else if (scene == 35) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: I'm sorry, I just needed my Catillac parts back!", 160, 600);
  } else if (scene == 36) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Whiskers: We understand, just make sure to be more careful", 160, 600);
    text("in the future", 160, 630);
  } else if (scene == 37) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: Of course! Landing in your territory was truly an accident!", 160, 600);
  } else if (scene == 38) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Whiskers: Alright, don't worry about it!", 160, 600);
  } else if (scene == 39) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: I want to apologize, so do you want to visit my planet?", 160, 600);
  } else if (scene == 40) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Whiskers: That sounds delightful!", 160, 600);
  } else if (scene == 41) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: Jump in the Catillac! We should be home in no time at all!", 160, 600);
  } else if (scene == 42) {
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Whiskers: We are all very excited, thank you for welcoming us!", 160, 600);
  } else if (scene == 43) {
    toggleN = true;
    cat.display();
    whiskers.display();
    image(spaceship, 300, 300, 300, 200);
    text("Luna: No problem!", 160, 600);
  } else if (scene == 44) {
    toggleN = false;
    winScenario();
  }
}

void keyPressed() {
  //spawns 10 enemies
  if (keyCode == 83) { //s
    spawn(5, 3, -3, 7);
  }

  //clears all enemies
  if (keyCode == 32) { //space
    enemies.clear();
  }

  //to cheat;))
  if (keyCode == 72) { //h
    health = 300;
  }

  //cheat code for instant win
  if (keyCode == 68) { //d
    totalDead = 30;
  }

  //cheat code for instant lose
  if (keyCode ==76) {
    health = 0;
  }

  //to advance scenes
  if (keyCode == 78) { //n
    if (toggleN) {
      scene++;
    }
  }

  println(keyCode);
}
