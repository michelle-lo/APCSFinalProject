import java.util.*;

class Enemy {
  float xPos;
  float yPos;
  float charWidth = 120;
  float charHeight = 75;
  color charColor;
  Queue<Integer> pattern = new LinkedList();
  int maxSize;
  int patternLen;
  boolean isDead;
  int numOfSymbols = 6;
  float dx;
  float dy;
  float v, a, t;
  Protaganist test = new Protaganist();
  boolean retreating = false;
  
  //constructor
  /*
  Enemy() {
    xPos = width / 2 + 100; //temp value
    yPos = height / 2 ; //temp value
    //charWidth = 120; //temporary values //125
    //charHeight = 75; //75 
    maxSize = 7; //subject to change
    patternLen = (int) ((Math.random() * (maxSize)) + 1); //max is 7
    pattern();
    isDead = false;
    float a = atan2(test.getY() - yPos, test.getX() - xPos);
    float v = dist(0, 0, dx, dy);
    dx = v * cos(a);
    dy = v * sin(a);
  }
  */
  Enemy(float x, float y, float upper, float lower, float maxLen) {
    xPos = x;
    yPos = y;
    //charWidth = 120; //temporary values
    //charHeight = 75; 
     
    patternLen = (int) ((Math.random() * (maxLen)) + 1); //max is 7
    if (maxLen == 0) {
      patternLen = 0;
    }
    pattern();
    isDead = false;
    dx = random(lower, upper + 1);
    dy = random(lower, upper + 1);
    float a = atan2(test.getY() - yPos, test.getX() - xPos);
    float v = dist(0, 0, dx, dy);
    dx = v * cos(a);
    dy = v * sin(a);
  }
  
  //adds a random assortment of symbols to enemy's pattern
  void pattern() {
    for (int i = 0; i < patternLen; i++) {
      pattern.add((int) (Math.random() * numOfSymbols));
    }
  }
  
  //display() displays enemies
  void display() {
    image(galaxyCat, xPos, yPos, charWidth, charHeight);
    //ellipse(xPos, yPos, charWidth, charHeight); //temporary ellipse to rep enemy
    String str = "";
    for (int symbol : pattern) {
      String ch = "";
      if (symbol == 0) {
        ch = "|";
      } else if (symbol == 1) {
        ch = "-";
      } else if (symbol == 2) {
        ch = "/";
      } else if (symbol == 3) {
        ch = "\\";
      } else if (symbol == 4) {
        ch = "v";
      } else {
        ch = "^";
      }
      str += ch + " ";
    }
    text(str, xPos, yPos - 50);
  }
  
  boolean isDead() {
    return isDead;
  }
  
  //getAttacked() gets rid of the first symbol of an enemy's pattern if the correct symbol is made by the player
  void getAttacked(int symbol) {
    if (pattern.size() == 1 && pattern.peek() == symbol) { //removes the enemy if no more symbols 
      pattern.remove();
      isDead = true;
    } else if (pattern.peek() == symbol) {
      pattern.remove();
    } 
    
  }
  
  //move() moves the enemy towards the protag. It bounces off the protag when it touches it but comes back. 
  void move() {
    xPos += dx;
    yPos += dy; //make sure to account for height
    if (retreating == false &&
        isTouching(xPos, yPos, charWidth, charHeight, test.getX(), test.getY(), test.getHeight(), test.getWidth())) {
      dx *= -4;
      dy *= -4;
      retreating = true;
      DoodleProject.getAttacked();
    } else if (retreating && dist(xPos, yPos, test.getX(), test.getY()) >= 400) {
      dx *= - 0.25;
      dy *= - 0.25;
      retreating = false;
    }
  }
  
  boolean isTouching(float thisX, float thisY, float thisW, float thisH, float protagX, float protagY, float protagH, float protagW) {
    if (thisX + thisW >= protagX &&    
      thisX + 25 <= protagX + protagW &&    
      thisY + thisH >= protagY &&    
      thisY + 25 <= protagY + protagH) {  
        return true;
    }
    return false;
  }
 
}
