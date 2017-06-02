import java.util.ArrayList;

ArrayList<String> images = new ArrayList<String>(); //keeps track of images
ArrayList<Integer> positions = new ArrayList<Integer>(); // keeps track of image positions [xcor,ycor]
ArrayList<Integer> attackingCards = new ArrayList<Integer>();
ArrayList<Integer> spellTargeting = new ArrayList<Integer>();
PImage bg;
/* float x_offset_drag;
 float y_offset_drag; */
boolean bover = false;
boolean locked = false;
ArrayList<PImage> image1 = new ArrayList<PImage>(); 
int newx, newy;
int whichImage;
boolean p1turn=true; //nicolas
boolean p2turn=false;  //chris
Player nicolas = new Player();
Player chris = new Player();
boolean spellMode = false;
int turnCounter=0;

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
  attackingCards.add(null);
  attackingCards.add(null);
  spellTargeting.add(null);
  spellTargeting.add(null);
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
  if (p2turn) {
    for (int j=0; j<nicolas.currentHand.size(); j++) {
      image(loadImage("Cards/Back.png"), 10+80*j, 470, 50, 50);
    }
  }
  if (p1turn) {
    for (int j=0; j<chris.currentHand.size(); j++) {
      image(loadImage("Cards/Back.png"), 10+80*j, 20, 50, 50);
    }
  }
  fillAttackingCard1();
  fillAttackingCard2();
  image(loadImage("Cards/PaladinIcon.png"),428,50,100,103);
  image(loadImage("Cards/ShamanIcon.png"),430,360,96,98);
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

void mouseClicked() {
  if ( (mouseX >=725) && (mouseX<=805) && (mouseY>=222) && (mouseY<272) ) //end turn
  {
    processCards1();
    processCards2();
    if (chris.deck.size()>0) {
      chris.drawCard();
    }
    if (nicolas.deck.size()>0) {
      nicolas.drawCard();
    } 
    printCurrentHanda();
    printCurrentHandb();
    p1turn=!p1turn;
    p2turn=!p2turn;
    attackingCards.set(0, null);
    attackingCards.set(1, null);
    for (int i=0; i<7; i++) {
      if (nicolas.monsters.get(i)!=null) {
        nicolas.monsters.get(i).attackedthisTurn=false;
      }
      if (chris.monsters.get(i)!=null) {
        chris.monsters.get(i).attackedthisTurn=false;
      }
    }
  if (turnCounter%2==1) {
    chris.incMP();
    turnCounter++;
  }
  if (turnCounter%2==0) {
    nicolas.incMP();
    turnCounter++;
  }
  System.out.println("Nicolas MP: " + nicolas.currentMP + "/" + nicolas.maxMP);
  System.out.println("Chris MP: " + chris.currentMP + "/" + chris.maxMP);
  }
  for (int i=0; i<7; i++) {
    if ( (mouseX>242+70*i) & (mouseX<292+70*i) & (mouseY>270) & (mouseY<320) & (nicolas.monsters.get(i)!=null) ) {
      attackingCards.set(0, i);
    }
  }
  if ( (mouseX>430) & (mouseX<526) & (mouseY>360) & (mouseY<458) ) {
    attackingCards.set(0,-1);}

  //-------------------------------SETTING TARGET
  for (int i=0; i<7; i++) {
    if ( (mouseX>242+70*i) & (mouseX<292+70*i) & (mouseY>185) & (mouseY<235) & (chris.monsters.get(i)!=null) ) {
      attackingCards.set(1, i);   
    }
    if ( (mouseX>428)& (mouseX<528)& (mouseY>50) &(mouseY<153)) {
    attackingCards.set(1,-1);} 
  }
  if (spellMode) {
    spellTargeting.set(1, attackingCards.get(1));
  }
}

void keyPressed() {
  if (key==ENTER) {
    System.out.println(attackingCards);
    int att = attackingCards.get(0);
    int rec = attackingCards.get(1);
    if (p1turn) {
      if (nicolas.monsters.get(att).attackedthisTurn==false) {
        int recDamage= chris.monsters.get(rec).value;
        Card placeholder = attackMonster(nicolas.monsters.get(att), chris.monsters.get(rec));
        chris.monsters.set(rec, placeholder);
        if (nicolas.monsters.get(att).currentHP<=recDamage) {
          nicolas.monsters.set(att, null);
        } else {
          nicolas.monsters.get(att).attackedthisTurn=true;
          nicolas.monsters.get(att).currentHP-=recDamage;
        }
        System.out.println("Chris" + chris.monsters.get(rec));
        System.out.println("Nicolas" + nicolas.monsters.get(att));
      }
    } else {
      attackingCards.set(0, null);
      System.out.println("Already attacked this turn");
    }
    if (p2turn) {
      if (chris.monsters.get(rec).attackedthisTurn==false) {
        int recDamage= nicolas.monsters.get(att).value;
        Card placeholder = attackMonster(chris.monsters.get(rec), nicolas.monsters.get(att));
        nicolas.monsters.set(att, placeholder);
        if (chris.monsters.get(rec).currentHP<=recDamage) {
          chris.monsters.set(rec, null);
        } else {
          chris.monsters.get(rec).attackedthisTurn=true;
          chris.monsters.get(rec).currentHP-=recDamage;
        }
        System.out.println("Chris" + chris.monsters.get(rec));
        System.out.println("Nicolas" + nicolas.monsters.get(att));
      } else {
        attackingCards.set(1, null);
        System.out.println("Already attacked this turn");
      }
    }
    attackingCards.set(0, null);
    attackingCards.set(1, null);
  }
  if (key=='s' || key=='S') {
    spellMode=!spellMode;
    System.out.println("Spell mode is " + spellMode);
    System.out.println(spellTargeting);
  }
}

void printCurrentHand1() {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    if (nicolas.currentHand.get(i).shown==false) {
      images.add(nicolas.currentHand.get(i).path);
      image1.add(loadImage(nicolas.currentHand.get(i).path));
      positions.add(10+80*i);
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
      positions.add(10+80*i);
      positions.add(20);
      chris.currentHand.get(i).shown=true;
    }
  }
}

void printCurrentHanda() {
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    if (nicolas.currentHand.get(i).shown==false) {
      images.add(i, nicolas.currentHand.get(i).path);
      image1.add(i, loadImage(nicolas.currentHand.get(i).path));
      positions.add(2*i, 0);
      positions.add(2*i+1, 0);
      nicolas.currentHand.get(i).shown=true;
    }
  }
  for (int i=0; i<nicolas.currentHand.size(); i++) {
    positions.set(2*i, 10+80*i);
    positions.set(2*i+1, 470);
  }
}

void printCurrentHandb() {
  for (int i=0; i<chris.currentHand.size(); i++) {
    if (chris.currentHand.get(i).shown==false) {
      images.add(chris.currentHand.get(i).path);
      image1.add(loadImage(chris.currentHand.get(i).path));
      positions.add(0);
      positions.add(0);
      chris.currentHand.get(i).shown=true;
    }
  }
  for (int i=0; i<chris.currentHand.size(); i++) {
    positions.set(2*nicolas.size()+2*i, 10+80*i);
    positions.set(2*nicolas.size()+2*i+1, 20);
  }
}


void fill() {
  //-----------------------------------nicolas's deck-----------------------------------------
  nicolas.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
  nicolas.deck.add(new Card(loadImage("Cards/BootyBayBodyGuard.jpg"), "Cards/BootyBayBodyGuard.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/BoulderfistOgre.jpg"), "Cards/BoulderfistOgre.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/ChillwindYeti.png"), "Cards/ChillwindYeti.png"));
  nicolas.deck.add(new Card(loadImage("Cards/ElvenArcher.jpg"), "Cards/ElvenArcher.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/FrostwolfGrunt.jpg"), "Cards/FrostwolfGrunt.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/GnomishInventor.jpg"), "Cards/GnomishInventor.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/GoldshireFootman.png"), "Cards/GoldshireFootman.png"));
  nicolas.deck.add(new Card(loadImage("Cards/Nightblade.jpg"), "Cards/Nightblade.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/NoviceEngineer.jpg"), "Cards/NoviceEngineer.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/OasisSnapjaw.jpg"), "Cards/OasisSnapjaw.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/RecklessRocketeer.jpg"), "Cards/RecklessRocketeer.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/RiverCrocolisk.png"), "Cards/RiverCrocolisk.png"));
  nicolas.deck.add(new Card(loadImage("Cards/SenjinShieldmaster.jpg"), "Cards/SenjinShieldmaster.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/StonetuskBoar.jpg"), "Cards/StonetuskBoar.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/StormpikeCommando.jpg"), "Cards/StormpikeCommando.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/StormwindKnight.jpg"), "Cards/StormwindKnight.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/VoodooDoctor.jpg"), "Cards/VoodooDoctor.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/WarGolem.jpg"), "Cards/WarGolem.jpg"));
  nicolas.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));

  //-----------------------------------Shaman Cards-----------------------------------------
  nicolas.deck.add(new Card(loadImage("Shaman/AlAkir.jpg"), "Shaman/AlAkir.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/AncestralKnowledge.jpg"), "Shaman/AncestralKnowledge.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/Bloodlust.jpg"), "Shaman/Bloodlust.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/Doomhammer.jpg"), "Shaman/Doomhammer.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/DustDevil.jpg"), "Shaman/DustDevil.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/EarthElemental.jpg"), "Shaman/EarthElemental.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/ElementalDestruction.png"), "Shaman/ElementalDestruction.png"));
  nicolas.deck.add(new Card(loadImage("Shaman/FeralSpirit.jpg"), "Shaman/FeralSpirit.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/FireElemental.jpg"), "Shaman/FireElemental.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/FlamewreathedFaceless.jpg"), "Shaman/FlamewreathedFaceless.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/FrostShot.jpg"), "Shaman/FrostShot.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/Hallazeal.jpg"), "Shaman/Hallazeal.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/Hex.jpg"), "Shaman/Hex.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/JinyuWaterspeaker.jpg"), "Shaman/JinyuWaterspeaker.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/LavaBurst.jpg"), "Shaman/LavaBurst.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/LightningBolt.jpg"), "Shaman/LightningBolt.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/LightningStorm.jpg"), "Shaman/LightningStorm.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/ManaTideTotem.jpg"), "Shaman/ManaTideTotem.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/RockbiterWeapon.jpg"), "Shaman/RockbiterWeapon.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/Stormcrack.jpg"), "Shaman/Stormcrack.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/StormforgedAxe.jpg"), "Shaman/StormforgedAxe.jpg"));
  nicolas.deck.add(new Card(loadImage("Shaman/TotemGolem.jpg"), "Shaman/TotemGolem.jpg"));

  //-----------------------------------chris's deck-----------------------------------------

  chris.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
  chris.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
  chris.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
  chris.deck.add(new Card(loadImage("Cards/BootyBayBodyGuard.jpg"), "Cards/BootyBayBodyGuard.jpg"));
  chris.deck.add(new Card(loadImage("Cards/BoulderfistOgre.jpg"), "Cards/BoulderfistOgre.jpg"));
  chris.deck.add(new Card(loadImage("Cards/ChillwindYeti.png"), "Cards/ChillwindYeti.png"));
  chris.deck.add(new Card(loadImage("Cards/ElvenArcher.jpg"), "Cards/ElvenArcher.jpg"));
  chris.deck.add(new Card(loadImage("Cards/FrostwolfGrunt.jpg"), "Cards/FrostwolfGrunt.jpg"));
  chris.deck.add(new Card(loadImage("Cards/GnomishInventor.jpg"), "Cards/GnomishInventor.jpg"));
  chris.deck.add(new Card(loadImage("Cards/GoldshireFootman.png"), "Cards/GoldshireFootman.png"));
  chris.deck.add(new Card(loadImage("Cards/Nightblade.jpg"), "Cards/Nightblade.jpg"));
  chris.deck.add(new Card(loadImage("Cards/NoviceEngineer.jpg"), "Cards/NoviceEngineer.jpg"));
  chris.deck.add(new Card(loadImage("Cards/OasisSnapjaw.jpg"), "Cards/OasisSnapjaw.jpg"));
  chris.deck.add(new Card(loadImage("Cards/RecklessRocketeer.jpg"), "Cards/RecklessRocketeer.jpg"));
  chris.deck.add(new Card(loadImage("Cards/RiverCrocolisk.png"), "Cards/RiverCrocolisk.png"));
  chris.deck.add(new Card(loadImage("Cards/SenjinShieldmaster.jpg"), "Cards/SenjinShieldmaster.jpg"));
  chris.deck.add(new Card(loadImage("Cards/StonetuskBoar.jpg"), "Cards/StonetuskBoar.jpg"));
  chris.deck.add(new Card(loadImage("Cards/StormpikeCommando.jpg"), "Cards/StormpikeCommando.jpg"));
  chris.deck.add(new Card(loadImage("Cards/StormwindKnight.jpg"), "Cards/StormwindKnight.jpg"));
  chris.deck.add(new Card(loadImage("Cards/VoodooDoctor.jpg"), "Cards/VoodooDoctor.jpg"));
  chris.deck.add(new Card(loadImage("Cards/WarGolem.jpg"), "Cards/WarGolem.jpg"));
  chris.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));

  //-----------------------------------Paladin Cards-----------------------------------------
  chris.deck.add(new Card(loadImage("Paladin/AldorPeacekeeper.jpg"), "Paladin/AldorPeacekeeper.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/BlessedChampion.jpg"), "Paladin/BlessedChampion.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/BlessingOfKings.jpg"), "Paladin/BlessingOfKings.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/BlessingOfMight.png"), "Paladin/BlessingOfMight.png"));
  chris.deck.add(new Card(loadImage("Paladin/Consecration.jpg"), "Paladin/Consecration.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/Dinosize.jpg"), "Paladin/Dinosize.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/DivineStrength.jpg"), "Paladin/DivineStrength.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/EadricThePure.jpg"), "Paladin/EadricThePure.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/Equality.jpg"), "Paladin/Equality.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/ForbiddenHealing.jpg"), "Paladin/ForbiddenHealing.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/GuardianOfKings.jpg"), "Paladin/GuardianOfKings.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/HammerOfWrath.jpg"), "Paladin/HammerOfWrath.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/HolyLight.png"), "Paladin/HolyLight.png"));
  chris.deck.add(new Card(loadImage("Paladin/Humility.png"), "Paladin/Humility.png"));
  chris.deck.add(new Card(loadImage("Paladin/KeeperOfUldaman.png"), "Paladin/KeeperOfUldaman.png"));
  chris.deck.add(new Card(loadImage("Paladin/LayOnHands.jpg"), "Paladin/LayOnHands.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/LightsJustice.jpg"), "Paladin/LightsJustice.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/LostInTheJungle.jpg"), "Paladin/LostInTheJungle.jpg"));
  //chris.deck.add(new Card(loadImage("Paladin/SealOfLight.png"), "Paladin/SealOfLight.png"));
  chris.deck.add(new Card(loadImage("Paladin/StandAgainstDarkness.jpg"), "Paladin/StandAgainstDarkness.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/SunkeeperTarim.jpg"), "Paladin/SunkeeperTarim.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/Tirion.jpg"), "Paladin/Tirion.jpg"));
  chris.deck.add(new Card(loadImage("Paladin/TruesilverChampion.jpg"), "Paladin/TruesilverChampion.jpg"));
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
//--------------------END OF DISPLAY MONSTER METHODS-----  

void fillAttackingCard1() {
  for (int i=0; i<7; i++) {
    if (attackingCards.get(0)!=null && nicolas.monsters.get(i)!=null) {
      if (attackingCards.get(0)==i) {
        fill(255, 0, 0);
        rect(238+70*i, 266, 58, 4);
        rect(238+70*i, 320, 58, 4);
        rect(238+70*i, 270, 4, 50);
        rect(292+70*i, 270, 4, 50);
      }
    }
  }
}

void fillAttackingCard2() {
  for (int i=0; i<7; i++) {
    if (attackingCards.get(1)!=null && chris.monsters.get(i)!=null) {
      if (attackingCards.get(1)==i) {
        fill(0, 255, 0);
        rect(238+70*i, 181, 58, 4);
        rect(238+70*i, 235, 58, 4);
        rect(238+70*i, 185, 4, 50);
        rect(292+70*i, 185, 4, 50);
      }
    }
  }
}

//---------------------------------------------------------
Card attackMonster(Card attacker, Card receiver) {
  receiver.currentHP-=attacker.value;
  if (receiver.currentHP>0) {
    return receiver;
  } else {
    return null;
  }
}