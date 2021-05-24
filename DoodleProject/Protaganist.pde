class Protaganist {
  PImage mainCharacter; 
  float xPos;
  float yPos;
  float charWidth;
  float charHeight;
  
  //constructor
  Protaganist() {
    xPos = width / 2;
    yPos = height / 2;
    charWidth = 100; //temporary values
    charHeight = 100; 
  }
  
  //display() summons the protag on the screen.
  void display() {
    ellipse(xPos, yPos, charWidth, charHeight); //temporary ellipse to rep protag
  }
}
