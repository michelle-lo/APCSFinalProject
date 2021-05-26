import java.util.*;
PImage backgroundImage;
Protaganist cat; 
int health = 5;

//coordinates of line drawn by player
float xi;
float yi;
float xf;
float yf;
float[] linePts = new float[4]; 
int symb;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

//setup() loads the background and creates the protaganist object.
void setup(){
  size(1000, 800);
  backgroundImage = loadImage("space.jpg");
  image(backgroundImage, 0, 0);
  backgroundImage.resize(1000, 800);
  image(backgroundImage, 0, 0);
  backgroundImage.loadPixels();
  cat = new Protaganist();
  symb = -1; //-1 indicates no symbol
}

void draw(){
  background(backgroundImage);
  cat.display();
  //displays all enemies unless dead
  for (int i = 0; i < enemies.size(); i++) {
    if (! enemies.get(i).isDead()) {
      enemies.get(i).display();
    } else {
      enemies.remove(i);
    }
  }
  text("Lives Left: " + health, 20, 40); 
  textSize(25);
  
  //player can draw lines anywhere on the screen
  if (mousePressed && mouseButton == LEFT) {
    stroke(225);
    strokeWeight(10);
    line(xi, yi, xf, yf);
  } else {
    xi = mouseX;
    yi = mouseY;
    xf = mouseX;
    yf = mouseY;
  }
}

void gameOverScreen(){
}

//mouseDragged() changes the end point coordinates of the line when the mouse is moving
void mouseDragged() { 
  if (mouseButton == LEFT) {
    xf = mouseX;
    yf = mouseY;
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
  if (mouseButton == LEFT) {
    stroke(0);
    xf = mouseX;
    yf = mouseY;
    println("xf: " + xf + " yf: " + yf);
    linePts[0] = xi;
    linePts[1] = yi;
    linePts[2] = xf;
    linePts[3] = yf;
    for (int i = 0; i < enemies.size(); i++) {
      symbolize();
      enemies.get(i).getAttacked(symb);
    }
    symb = -1;
    //symbolize();

  } else { //creates new enemy at mouse location (for testing purposes)
    Enemy test = new Enemy(mouseX, mouseY);
    enemies.add(test);
  } 
  
  
  
}

//symbolize() recognizes the symbol based on the slope of the line created.
void symbolize() {
  String test = "len: "; 
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
}
