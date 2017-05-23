String[] images = {"Cards/Wolfrider.jpg", "Cards/VoodooDoctor.jpg"}; //keeps track of images

float[] positions =new float[images.length*2]; // keeps track of image positions [xcor,ycor]

PImage bg;
float bx;
float by;
int bs = 40;
int bz = 30;
float easing = .05;
float x_offset_drag;
float y_offset_drag;
boolean bover = false;
boolean locked = false;
float bdifx = 0.0; 
float bdify = 0.0; 
PImage[] image1 = new PImage [images.length]; 
float newx, newy;
int whichImage;

void setup() {
  size(960, 540);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 960 x 540 pixels.
  bx = width/2.0;
  by = height/2.0;
  bg = loadImage("background.png");

  for (int i=0; i < images.length; i++) {
    image1 [i]= loadImage(images[i]); 
    image (image1[i], random(width), random(height), 50, 50) ;
  } 

  for (int j=0; j < images.length*2; j+=2) {
    positions[j]= random(width);
    positions[j+1]= random(height);
  }
}

void draw() {
  background(bg);  
  for (int i=0; i < images.length; i++) {
    if (mouseX > positions[i*2]-bs && mouseX < positions[i*2]+bs && 
      mouseY > positions[i*2+1]-bs && mouseY < positions[i*2+1]+bs) 
    {
      /*println ("mouseover image: "+i);
      whichImage=i;*/
      

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
  for (int j=0; j < images.length; j++) {
    image (image1[j], positions[j*2], positions[j*2+1], 50, 50) ;
  }
  fill(87);
  // top monster slots
  rect(237,180,60,60);
  rect(307,180,60,60);
  rect(377,180,60,60);
  rect(447,180,60,60);
  rect(517,180,60,60);
  rect(587,180,60,60);
  rect(657,180,60,60);
  // bottom monster slots
  rect(237,265,60,60);
  rect(307,265,60,60);
  rect(377,265,60,60);
  rect(447,265,60,60);
  rect(517,265,60,60);
  rect(587,265,60,60);
  rect(657,265,60,60);
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
    newx = mouseX - x_offset_drag - 25; 
    newy = mouseY - y_offset_drag - 25;
    fill(50,205,50);
    rect(newx-2, newy-2, 54, 2); // top border
    rect(newx-2, newy, 2, 50); // left border
    rect(newx-2, newy+50, 54, 2); // bottom border
    rect(newx+50, newy, 2, 50); // right border 
  }

  positions [whichImage*2] = newx;
  positions [(whichImage*2)+1] = newy;
}

void mouseReleased() {
  locked = false;
}

void keyPressed() {
  isCardOver();
}

void isCardOver() {
  for (int j=0; j < images.length*2; j+=2) {
    if ((positions[j] > 232) && (positions[j] < 302) && (positions[j+1]>265) && (positions[j+1]<335)) {
      System.out.println(true);
    }
    else {
      System.out.println(false);
    }
  }
}
