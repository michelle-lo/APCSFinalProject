import java.util.*;
PImage backgroundImage;
Protaganist cat; 
int health = 5;


//coordinates of line drawn by player
float xi;
float yi;
float xf;
float yf;

//setup() loads the background and creates the protaganist object.
void setup(){
  size(1000, 800);
  backgroundImage = loadImage("space.jpg");
  image(backgroundImage, 0, 0);
  backgroundImage.resize(1000, 800);
  image(backgroundImage, 0, 0);
  backgroundImage.loadPixels();
  cat = new Protaganist();
 
}

void draw(){
  background(backgroundImage);
  cat.display();
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
  }
}
