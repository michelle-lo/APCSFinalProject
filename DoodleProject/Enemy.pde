import java.util.*;

class Enemy {
  float xPos;
  float yPos;
  float charWidth;
  float charHeight;
  color charColor;
  Queue<Integer> pattern = new LinkedList();

  
  
  //constructor
  Enemy() {
    xPos = width / 2 + 100; //temp value
    yPos = height / 2 ; //temp value
    charWidth = 75; //temporary values
    charHeight = 75; 

  }
  
  Enemy(float x, float y) {
    xPos = x;
    yPos = y;
    charWidth = 75; //temporary values
    charHeight = 75; 

  }
}
