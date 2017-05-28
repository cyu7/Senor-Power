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
Player chris = new Player();

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
  chris.drawCard();
  chris.drawCard();
  chris.drawCard();
  nicolas.drawCard();
  nicolas.drawCard();
  nicolas.drawCard();
  printCurrentHand1();
  printCurrentHand2();
  System.out.println(images);
}

void draw() {
  background(bg);  
  for (int i=0; i < images.size(); i++) {
    if (mouseX > positions.get(i*2)-40 && mouseX < positions.get(i*2)+40 && 
      mouseY > positions.get(i*2+1)-40 && mouseY < positions.get(i*2+1)+40) 
    {
      // println ("mouseover image; "+i); 
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
  displayMonsters1();
  displayMonsters2();
  printCurrentHand1();
  printCurrentHand2();
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
  processCards1();
  processCards2();
  chris.drawCard();
  nicolas.drawCard();
  printCurrentHandb();
  printCurrentHanda();
  System.out.println("\n" +images);
}

void printCurrentHand1() {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    if (nicolas.currentHand.get(i).shown==false) {
      images.add(nicolas.currentHand.get(i).path);
      image1.add(loadImage(nicolas.currentHand.get(i).path));
      positions.add(10+100*i);
      positions.add(470);
      nicolas.currentHand.get(i).shown=true;
    }
  }
}

void printCurrentHand2() {
  for (int i=0; i<chris.currentHand.size(); i++) {
    if (chris.currentHand.get(i).shown==false) {
      images.add(chris.currentHand.get(i).path);
      image1.add(loadImage(chris.currentHand.get(i).path));
      positions.add(10+100*i);
      positions.add(20);
      chris.currentHand.get(i).shown=true;
    }
  }
}

void printCurrentHanda() {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    if (nicolas.currentHand.get(i).shown==false) {
      images.add(nicolas.size(),nicolas.currentHand.get(i).path);
      image1.add(nicolas.size(),loadImage(nicolas.currentHand.get(i).path));
      positions.add(2*nicolas.size(),10+100*i);
      positions.add(2*nicolas.size()+1,470);
      nicolas.currentHand.get(i).shown=true;
    }
  }
}

void printCurrentHandb() {
  for (int i=0; i<chris.currentHand.size(); i++) {
    if (chris.currentHand.get(i).shown==false) {
      images.add(nicolas.size(),chris.currentHand.get(i).path);
      image1.add(nicolas.size(),loadImage(chris.currentHand.get(i).path));
      positions.add(nicolas.size(),10+100*i);
      positions.add(nicolas.size()+1,20);
      chris.currentHand.get(i).shown=true;
    }
  }
}

void fill() {
  nicolas.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
  nicolas.deck.add(new Card(loadImage("Cards/Nightblade.jpg"), "Cards/Nightblade.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/NoviceEngineer.jpg"), "Cards/NoviceEngineer.jpg"));
  chris.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));
  chris.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
  chris.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
  chris.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
  chris.deck.add(new Card(loadImage("Cards/Nightblade.jpg"), "Cards/Nightblade.jpg"));
  chris.deck.add(new Card(loadImage("Cards/NoviceEngineer.jpg"), "Cards/NoviceEngineer.jpg"));
}

//-------------------------- BOTTOM CARDOVER METHODS (7)-----------------
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

//-------------------------- END OF BOTTOM CARDOVER METHODS (7)-----------------
//-------------------------- TOP CARDOVER METHODS (7)-----------------

int CardOver8() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 213) && (positions.get(j)< 271) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver9() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 283) && (positions.get(j)< 341) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver10() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 353) && (positions.get(j)< 411) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver11() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 423) && (positions.get(j)< 481) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver12() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 493) && (positions.get(j)< 551) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver13() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 563) && (positions.get(j)< 621) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

int CardOver14() {
  for (int j=0; j < images.size()*2; j+=2) {
    if ((positions.get(j) > 633) && (positions.get(j)< 691) && (positions.get(j+1)>156) && (positions.get(j+1)<214)) {
      return j/2;
    }
  }
  return -1;
}

//-------------------------- END OF TOP CARDOVER METHODS (7)-----------------
//----------------------BOTTOM PLAYER PROCESS----------------------------------
void processCards1() {
  int index1 = CardOver1();
  if (index1 != -1) {
    nicolas.addMonster(0, new Card(image1.get(index1), images.get(index1)));
    nicolas.currentHand.remove(index1);
    images.remove(index1);
    image1.remove(index1);
    positions.remove(2*index1);
    positions.remove(2*index1);
  }

  int index2 = CardOver2();
  if (index2 != -1) {
    nicolas.addMonster(1, new Card(image1.get(index2), images.get(index2)));
    nicolas.currentHand.remove(index2);
    images.remove(index2);
    image1.remove(index2);
    positions.remove(2*index2);
    positions.remove(2*index2);
  }

  int index3 = CardOver3(); 
  if (index3 != -1) {
    nicolas.addMonster(2, new Card(image1.get(index3), images.get(index3)));
    nicolas.currentHand.remove(index3);
    images.remove(index3);
    image1.remove(index3);
    positions.remove(2*index3);
    positions.remove(2*index3);
  }

  int index4 = CardOver4();
  if (index4 != -1) {
    nicolas.addMonster(3, new Card(image1.get(index4), images.get(index4)));
    nicolas.currentHand.remove(index4);
    images.remove(index4);
    image1.remove(index4);
    positions.remove(2*index4);
    positions.remove(2*index4);
  }

  int index5 = CardOver5();
  if (index5 != -1) {
    nicolas.addMonster(4, new Card(image1.get(index5), images.get(index5)));
    nicolas.currentHand.remove(index5);
    images.remove(index5);
    image1.remove(index5);
    positions.remove(2*index5);
    positions.remove(2*index5);
  }

  int index6 = CardOver6();
  if (index6 != -1) {
    nicolas.addMonster(5, new Card(image1.get(index6), images.get(index6)));
    nicolas.currentHand.remove(index6);
    images.remove(index6);
    image1.remove(index6);
    positions.remove(2*index6);
    positions.remove(2*index6);
  }

  int index7 = CardOver7();
  if (index7 != -1) {
    nicolas.addMonster(6, new Card(image1.get(index7), images.get(index7)));
    nicolas.currentHand.remove(index7);
    images.remove(index7);
    image1.remove(index7);
    positions.remove(2*index7);
    positions.remove(2*index7);
  }
}
//----------------------END OF BOTTOM PLAYER PROCESS----------------------------------
//----------------------TOP PLAYER PROCESS----------------------------------
void processCards2() {
  int index8 = CardOver8();
  if (index8 != -1) {
    chris.addMonster(0, new Card(image1.get(index8), images.get(index8)));
    index8-=nicolas.size();
    chris.currentHand.remove(index8);
    index8+=nicolas.size();
    images.remove(index8);
    image1.remove(index8);
    positions.remove(2*index8);
    positions.remove(2*index8);
  }

  int index9 = CardOver9();
  if (index9 != -1) {
    chris.addMonster(1, new Card(image1.get(index9), images.get(index9)));
    index9-=nicolas.size();
    chris.currentHand.remove(index9);
    index9+=nicolas.size();
    images.remove(index9);
    image1.remove(index9);
    positions.remove(2*index9);
    positions.remove(2*index9);
  }

  int index10 = CardOver10(); 
  if (index10 != -1) {
    chris.addMonster(2, new Card(image1.get(index10), images.get(index10)));
    index10-=nicolas.size();
    chris.currentHand.remove(index10);
    index10+=nicolas.size();
    images.remove(index10);
    image1.remove(index10);
    positions.remove(2*index10);
    positions.remove(2*index10);
  }

  int index11 = CardOver11();
  if (index11 != -1) {
    chris.addMonster(3, new Card(image1.get(index11), images.get(index11)));
    index11-=nicolas.size();
    chris.currentHand.remove(index11);
    index11+=nicolas.size();
    images.remove(index11);
    image1.remove(index11);
    positions.remove(2*index11);
    positions.remove(2*index11);
  }

  int index12 = CardOver12();
  if (index12 != -1) {
    chris.addMonster(4, new Card(image1.get(index12), images.get(index12)));
    index12-=nicolas.size();
    chris.currentHand.remove(index12);
    index12+=nicolas.size();
    images.remove(index12);
    image1.remove(index12);
    positions.remove(2*index12);
    positions.remove(2*index12);
  }

  int index13 = CardOver13();
  if (index13 != -1) {
    chris.addMonster(5, new Card(image1.get(index13), images.get(index13)));
    index13-=nicolas.size();
    chris.currentHand.remove(index13);
    index13+=nicolas.size();
    images.remove(index13);
    image1.remove(index13);
    positions.remove(2*index13);
    positions.remove(2*index13);
  }

  int index14 = CardOver14();
  if (index14 != -1) {
    chris.addMonster(6, new Card(image1.get(index14), images.get(index14)));
    index14-=nicolas.size();
    chris.currentHand.remove(index14);
    index14+=nicolas.size();
    images.remove(index14);
    image1.remove(index14);
    positions.remove(2*index14);
    positions.remove(2*index14);
  }
}
//----------------------END OF TOP PLAYER PROCESS----------------------------------

void displayMonsters1() {
  for (int i=0; i<7; i++) {
      if (nicolas.monsters.get(i)!=null) {
      Card a = nicolas.monsters.get(i);
      PImage b = loadImage(a.path);
      image(b, 242 + 70*i, 270, 50, 50);
      nicolas.monsters.get(i).shown=true;
    }
  }
}

void displayMonsters2() {
  for (int i=0; i<7; i++) {
      if (chris.monsters.get(i)!=null) {
      Card a = chris.monsters.get(i);
      PImage b = loadImage(a.path);
      image(b, 242 + 70*i, 185, 50, 50);
      chris.monsters.get(i).shown=true;
    }
  }
}