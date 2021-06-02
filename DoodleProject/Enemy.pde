import java.util.*;
//restrict the bound for the speed at which the enemy moves



class Enemy {
  float xPos;
  float yPos;
  float charWidth;
  float charHeight;
  color charColor;
  Queue<Integer> pattern = new LinkedList();
  int maxSize;
  int patternLen;
  boolean isDead;
  int numOfSymbols = 6;
  float dx = random(6)-3;
  float dy = random(6)-3;
  float v, a, t;
  Protaganist test = new Protaganist();
  boolean retreating = false; 
  
  //constructor
  Enemy() {
    xPos = width / 2 + 100; //temp value
    yPos = height / 2 ; //temp value
    charWidth = 75; //temporary values
    charHeight = 75; 
    maxSize = 7; //subject to change
    patternLen = (int) ((Math.random() * (maxSize)) + 1); //max is 7
    pattern();
    isDead = false;
    float a = atan2(test.getY() - yPos, test.getX() - xPos);
    float v = dist(0, 0, dx, dy);
    dx = v * cos(a);
    dy = v * sin(a);
  }
  
  Enemy(float x, float y) {
    xPos = x;
    yPos = y;
    charWidth = 75; //temporary values
    charHeight = 75; 
    maxSize = 7; 
    patternLen = (int) ((Math.random() * (maxSize)) + 1); //max is 7
    pattern();
    isDead = false;
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
    ellipse(xPos, yPos, charWidth, charHeight); //temporary ellipse to rep enemy
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
  
  void move() {
    xPos += dx;
    yPos += dy;
    if (retreating == false && dist(xPos, yPos, test.getX(), test.getY()) <= charWidth) {
      dx *= -1;
      dy *= -1;
      retreating = true;
      println(retreating);
    } 
    
    //either have collision detection with the edge of the screen 
    //or move backwards with each touch (certain distance or ticks)
    //this depends on the number of enemeies at a given time/what we decide on
    
    /*else if (retreating && dist(xPos, yPos, test.getX(), test.getY()) <= 100) {
      println("hello?");
      dx *= -1;
      dy *= -1;
      retreating = false;
    } else {
      //xPos += dx;
      //yPos += dy;
    }
    */
    
    //if (xPos >= width - charWidth || xPos <= charWidth) dx *= -1;
    //if (yPos >= height - charWidth || yPos <= charWidth) dy *= -1;
  }
 
}
