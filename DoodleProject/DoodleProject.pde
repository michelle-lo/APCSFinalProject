import java.util.*;
PImage backgroundImage;
PImage catCharacter;
PImage galaxyCat;
Protaganist cat; 
static int health = 5;

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

//setup() loads the background and creates the protaganist object.
void setup(){
  size(1000, 800);
  backgroundImage = loadImage("space.jpg");
  catCharacter = loadImage("croppedNyanCat.png");
  galaxyCat = loadImage("croppedGalaxyCat.png");
  imageMode(CENTER);
  image(backgroundImage, 0, 0);
  backgroundImage.resize(1000, 800);
  image(backgroundImage, 0, 0);
  backgroundImage.loadPixels();
  cat = new Protaganist();
  symb = -1; //-1 indicates no symbol
}

void draw(){
  background(backgroundImage); 
  text("Lives Left: " + health, 20, 40); 
  textSize(25);
  cat.display();
  enemyDisplay();
  drawLine();
  endScreen();
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
      enemies.remove(i);
    }
  }
}

//switches to lose background
void endScreen() {
  if (health <= 0){
    size(1000, 800);
    backgroundImage = loadImage("croppedGameOver.jpg");
    backgroundImage.resize(1000, 800);
    backgroundImage.loadPixels();
    background(backgroundImage);
  }
}

//spawn() spawns number of enemies randomly on the sides of the screen. 
void spawn(int numEnemies) {
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
    Enemy e = new Enemy(enemyX, enemyY);
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
    Enemy test = new Enemy(mouseX, mouseY);
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

void keyPressed() {
  //spawns 10 enemies
  if (keyCode == 83) { //s
    spawn(5);
  }
  
  //clears all enemies
  if (keyCode == 32) { //space
    enemies.clear();
  }
  
  //to cheat;))
  if (keyCode == 72) { //h
    health = 300;  
  }
  
  println(keyCode);
}
