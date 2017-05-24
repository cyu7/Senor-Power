import java.util.ArrayList;

ArrayList<String> images = new ArrayList<String>(); //keeps track of images
ArrayList<Integer> positions = new ArrayList<Integer>(); // keeps track of image positions [xcor,ycor]

PImage bg;
/* float x_offset_drag;
float y_offset_drag; */
boolean bover = false;
boolean locked = false;
ArrayList<PImage> image1 = new ArrayList<PImage>(); 
int newx, newy;
int whichImage;
Player nicolas = new Player();

void setup() {
  size(960, 540);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 960 x 540 pixels.
  bg = loadImage("background.png");

  images.add("Cards/Wolfrider.jpg");
  images.add("Cards/Wolfrider.jpg");
  images.add("Cards/Wolfrider.jpg");

  System.out.println(images.size());
  for (int i=0; i < images.size(); i++) {
    image1.add(loadImage(images.get(i))); 
    image (image1.get(i), 241, 185 + 70*i, 50, 50) ;
  } 

  for (int j=0; j < images.size()*2; j+=2) {
    positions.add(241+70*j);
    positions.add(185);
  }
}

void draw() {
  background(bg);  
  for (int i=0; i < images.size(); i++) {
    if (mouseX > positions.get(i*2)-40 && mouseX < positions.get(i*2)+40 && 
      mouseY > positions.get(i*2+1)-40 && mouseY < positions.get(i*2+1)+40) 
    {
      /*println ("mouseover image: "+i); */
      whichImage=i; 


      bover = true;  
      if (!locked) 
      { 
        stroke(255); 
        fill(153);
      }
      break;
    } else
    {
      stroke(153);
      fill(153);
      bover = false;
    }
  }
  for (int j=0; j < images.size(); j++) {
    image (image1.get(j), positions.get(j*2), positions.get(j*2+1), 50, 50) ;
  }
  for (int i=237; i<=657; i+=70) {
    //top monster slots
    rect(i, 180, 60, 1);
    rect(i, 239, 60, 1);
    rect(i, 181, 1, 58);
    rect(i+59, 181, 1, 58);
    //bottom monster slots
    rect(i, 265, 60, 1);
    rect(i, 324, 60, 1);
    rect(i, 266, 1, 58);
    rect(i+59, 266, 1, 58);
  }
}

void mousePressed() {
  if (bover) { 
    locked = true;
  } else {
    locked = false;
  }
}

void mouseDragged() {
  if (locked) {
    newx = mouseX - 25; 
    newy = mouseY - 25;
    fill(50, 205, 50);
    rect(newx-2, newy-2, 54, 2); // top border
    rect(newx-2, newy, 2, 50); // left border
    rect(newx-2, newy+50, 54, 2); // bottom border
    rect(newx+50, newy, 2, 50); // right border
  }
  positions.set(whichImage*2, newx);
  positions.set(whichImage*2+1, newy);
}

void mouseReleased() {
  locked = false;
}

void keyPressed() {
  nicolas.draw();
  printCurrentHand(nicolas);
}

void printCurrentHand(Player nicolas) {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    images.add(nicolas.currentHand.get(i).path);
    image1.add(loadImage(nicolas.currentHand.get(i).path));
    positions.add((int) random(960));
    positions.add((int) random(540));
  }
}


int CardOver() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 232) && (positions.get(j)< 302) && (positions.get(j+1)>265) && (positions.get(j+1)<335)) {
      return j/2;
    }
  }
  return -1;
}