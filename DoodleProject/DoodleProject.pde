PImage backgroundImage;
Protaganist cat; 

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
}
