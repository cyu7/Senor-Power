class Background{
 
PImage bg;

void setup() {
  size(650, 350);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 1920 x 1080 pixels.
  bg = loadImage("test.jpeg");
}

void draw() {
  background(bg);  
}

}