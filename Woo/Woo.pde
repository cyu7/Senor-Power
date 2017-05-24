String[] images = {"Cards/Wolfrider.jpg", "Cards/VoodooDoctor.jpg", "Cards/StonetuskBoar.jpg"}; //keeps track of images

float[] positions =new float[images.length*2]; // keeps track of image positions [xcor,ycor]

PImage bg;
float x_offset_drag;
float y_offset_drag;
boolean bover = false;
boolean locked = false;
PImage[] image1 = new PImage [images.length]; 
float newx, newy;
int whichImage;
Player nicolas = new Player();

void setup() {
  size(960, 540);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 960 x 540 pixels.
  bg = loadImage("background.png");

  for (int i=0; i < images.length; i++) {
    image1 [i]= loadImage(images[i]); 
    image (image1[i], 241, 185 + 70*i, 50, 50) ;
  } 

  for (int j=0; j < images.length*2; j+=2) {
    positions[j]= 241+70*j;
    positions[j+1]= 185;
  }
}

void draw() {
  background(bg);  
  for (int i=0; i < images.length; i++) {
    if (mouseX > positions[i*2]-40 && mouseX < positions[i*2]+40 && 
      mouseY > positions[i*2+1]-40 && mouseY < positions[i*2+1]+40) 
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
  for (int j=0; j < images.length; j++) {
    image (image1[j], positions[j*2], positions[j*2+1], 50, 50) ;
  }
  fill(87);
  for (int i=237; i<=657; i+=70) {
    //top monster slots
    rect(i,180,60,1);
    rect(i,239,60,1);
    rect(i,181,1,58);
    rect(i+59,181,1,58);
    //bottom monster slots
    rect(i,265,60,1);
    rect(i,324,60,1);
    rect(i,266,1,58);
    rect(i+59,266,1,58);
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
  int a = CardOver();
  String pikturePath = images[a];
  PImage pikture = loadImage(pikturePath);
  Card put = new Card(pikture, pikturePath);
  nicolas.addMonster(put);
}


int CardOver() {
  for (int j=0; j < images.length*2; j+=2) {
    if ((positions[j] > 232) && (positions[j] < 302) && (positions[j+1]>265) && (positions[j+1]<335)) {
      return j/2;
    }
  }
  return -1;
}