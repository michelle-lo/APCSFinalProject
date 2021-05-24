PImage backgroundImage;

void setup(){
  size(576, 360);
  backgroundImage = loadImage("space.jpg");
  backgroundImage.loadPixels();
}

void draw(){
  background(backgroundImage);
}
