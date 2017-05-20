PImage bg;
PImage card;
PImage dragCard;
float testx=100;
float testy=100;
float easing = .05;
float x_offset_drag;
float y_offset_drag;
boolean locked = false;

void setup() {
  size(960, 540);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 1920 x 1080 pixels.
  bg = loadImage("background.png");
  card = loadImage("Cards/Wolfrider.jpg");
  smooth();
  dragCard = loadImage("Cards/Wolfrider.jpg");
}

void draw() {
  background(bg);  
  image(card, 100, 100);
  image(dragCard, testx, testy);
}

void mousePressed() {
  float w = dragCard.width/2;
  float h = dragCard.height/2;
  if ((mouseX < testx+w+50) && (mouseY < testy+h+50) && (mouseX > testx+w-50) && (mouseY > testy+h-50)) {
    testx = mouseX - x_offset_drag - w;
    testy = mouseY - y_offset_drag - h;
    locked = true;
    cursor(HAND);}
}

void mouseDragged() {
  float w = dragCard.width/2;
  float h = dragCard.height/2;
  if (locked) {
    testx = mouseX - x_offset_drag - w;
    testy = mouseY - y_offset_drag - h;
  }
}

void mouseReleased() {
  locked = false;
  cursor(ARROW);
}