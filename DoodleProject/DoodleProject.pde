PImage backgroundImage;

void setup(){
  size(1000, 800);
  backgroundImage = loadImage("space.jpg");
  image(backgroundImage, 0, 0);
  backgroundImage.resize(1000, 800);
  image(backgroundImage, 0, 0);
  backgroundImage.loadPixels();
}

void draw(){
  background(backgroundImage);
}
