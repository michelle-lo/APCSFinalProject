import java.util.*;

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
 
}
