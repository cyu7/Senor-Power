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

  for (int i=0; i < images.size(); i++) {
    image1.add(loadImage(images.get(i))); 
    image (image1.get(i), 241, 185 + 70*i, 50, 50) ;
  } 

  for (int j=0; j < images.size()*2; j+=2) {
    positions.add(241+70*j);
    positions.add(185);
  }
  fill();
  nicolas.drawCard();
  nicolas.drawCard();
  nicolas.drawCard();
  printCurrentHand(nicolas);
}

void draw() {
  background(bg);  
  for (int i=0; i < images.size(); i++) {
    if (mouseX > positions.get(i*2)-40 && mouseX < positions.get(i*2)+40 && 
      mouseY > positions.get(i*2+1)-40 && mouseY < positions.get(i*2+1)+40) 
    {
      /*println ("mouseover image; "+i); */
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
  System.out.println(nicolas.monsters.size());
  processCards();
  System.out.println(nicolas.monsters);
  System.out.println(nicolas.currentHand);
  nicolas.drawCard(); // put in clump method
  
}

void printCurrentHand(Player nicolas) {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    images.add(nicolas.currentHand.get(i).path);
    image1.add(loadImage(nicolas.currentHand.get(i).path));
    positions.add(320+100*i);
    positions.add(470);
  }
}

void fill() {
  nicolas.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
  nicolas.deck.add(new Card(loadImage("Cards/Nightblade.jpg"), "Cards/Nightblade.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/NoviceEngineer.jpg"), "Cards/NoviceEngineer.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/OasisSnapjaw.jpg"), "Cards/OasisSnapjaw.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/VoodooDoctor.jpg"), "Cards/VoodooDoctor.jpg"));
}

//--------------------------CARDOVER METHODS (7)-----------------
int CardOver1() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 213) && (positions.get(j)< 271) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver2() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 283) && (positions.get(j)< 341) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver3() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 353) && (positions.get(j)< 411) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver4() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 423) && (positions.get(j)< 481) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver5() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 493) && (positions.get(j)< 551) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver6() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 563) && (positions.get(j)< 621) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver7() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 633) && (positions.get(j)< 691) && (positions.get(j+1)>241) && (positions.get(j+1)<299)) {
      return j/2;
    }
  }
  return -1;
}

//--------------------------END OF CARDOVER METHODS (7)-----------------

void processCards() {
  int index1 = CardOver1();
  int index2 = CardOver2();
  int index3 = CardOver3();
  int index4 = CardOver4();
  int index5 = CardOver5();
  int index6 = CardOver6();
  int index7 = CardOver7();
  
  if (index1 != -1) {
    nicolas.monsters.set(0, new Card(image1.get(index1), images.get(index1)));
    nicolas.currentHand.remove(index1);
    images.remove(index1);
    image1.remove(index1);
    positions.remove(2*index1);
    positions.remove(2*index1);
  }
  
  if (index2 != -1) {
    nicolas.monsters.set(1, new Card(image1.get(index2), images.get(index2)));
    nicolas.currentHand.remove(index2);
    images.remove(index2);
    image1.remove(index2);
    positions.remove(2*index2);
    positions.remove(2*index2);
  }
  
  if (index3 != -1) {
    nicolas.monsters.set(2, new Card(image1.get(index3), images.get(index3)));
    nicolas.currentHand.remove(index3);
    images.remove(index3);
    image1.remove(index3);
    positions.remove(2*index3);
    positions.remove(2*index3);
  }
  
  if (index4 != -1) {
    nicolas.monsters.set(3, new Card(image1.get(index4), images.get(index4)));
    nicolas.currentHand.remove(index4);
    images.remove(index4);
    image1.remove(index4);
    positions.remove(2*index4);
    positions.remove(2*index4);
  }
  
  if (index5 != -1) {
    nicolas.monsters.set(4, new Card(image1.get(index5), images.get(index5)));
    nicolas.currentHand.remove(index5);
    images.remove(index5);
    image1.remove(index5);
    positions.remove(2*index5);
    positions.remove(2*index5);
  }
  
  if (index6 != -1) {
    nicolas.monsters.set(5, new Card(image1.get(index6), images.get(index6)));
    nicolas.currentHand.remove(index6);
    images.remove(index6);
    image1.remove(index6);
    positions.remove(2*index6);
    positions.remove(2*index6);
  }
  
  if (index7 != -1) {
    nicolas.monsters.set(6, new Card(image1.get(index7), images.get(index7)));
    nicolas.currentHand.remove(index7);
    images.remove(index7);
    image1.remove(index7);
    positions.remove(2*index7);
    positions.remove(2*index7);
  }
}

/*void displayMonsters1() {
 if () } */