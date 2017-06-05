import java.util.ArrayList;

/*Bugs:
 user putting cards on the wrong side of the board
 user trying to load a non-monster
 user trying to load a non-weapon on the weapons slot
 different toString for different types of cards
 make other player's cards undraggable on your turn
 yellow border still there after spell mode off
*/

ArrayList<String> images = new ArrayList<String>(); //keeps track of images
ArrayList<Integer> positions = new ArrayList<Integer>(); // keeps track of image positions [xcor,ycor]
ArrayList<Integer> attackingCards = new ArrayList<Integer>();
ArrayList<Integer> spellTargeting = new ArrayList<Integer>();
PImage bg;
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
  chris.decMP(1);
  chris.maxMP=0;
  for (int i=0; i<3; i++) {
    chris.drawCard();
    nicolas.drawCard();
  }
  printCurrentHand1();
  printCurrentHand2();
  for (int i=0; i<2; i++) {
    attackingCards.add(null);
    spellTargeting.add(null);
  }
}

void draw() {
  background(bg);  
  for (int i=0; i < images.size(); i++) {
    if (mouseX > positions.get(i*2) && mouseX < positions.get(i*2)+50 && 
      mouseY > positions.get(i*2+1) && mouseY < positions.get(i*2+1)+50) 
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
  for (int i=0; i<2; i++) {
  rect(355, 90+300*i, 60, 1);
  rect(355, 149+300*i, 60, 1);
  rect(355, 91+300*i, 1, 58);
  rect(414, 91+300*i, 1, 58);
  rect(540, 90+300*i, 60, 1);
  rect(540, 149+300*i, 60, 1);
  rect(540, 91+300*i, 1, 58);
  rect(599, 91+300*i, 1, 58);
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
  image(loadImage("Cards/PaladinIcon.png"), 428, 50, 100, 103);
  image(loadImage("Cards/ShamanIcon.png"), 430, 360, 96, 98);

  displayMana(nicolas, 400);
  displayMana(chris, 60);

  fillSpellCard();
}


void mousePressed() {
  if (bover) { 
    locked = true;
    if (whichImage>=nicolas.size()) {
      System.out.println(chris.currentHand.get(whichImage-nicolas.size()));
    }
    else{
      System.out.println(nicolas.currentHand.get(whichImage));
    }
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
  //---------------------------END TURN--------------------------------
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
    spellTargeting.set(0, null);
    spellTargeting.set(1, null);
    spellMode=false;
    for (int i=0; i<7; i++) {
      if (nicolas.monsters.get(i)!=null) {
        nicolas.monsters.get(i).attackedthisTurn=false;
      }
      if (chris.monsters.get(i)!=null) {
        chris.monsters.get(i).attackedthisTurn=false;
      }
    }
    if (turnCounter%2==1) {
      nicolas.incMP();
      turnCounter++;
    } else {
      chris.incMP();
      turnCounter++;
    }
  }
  //--------------------------END OF END TURN ----------------------------

  for (int i=0; i<7; i++) {
    if ( (mouseX>242+70*i) & (mouseX<292+70*i) & (mouseY>270) & (mouseY<320) & (nicolas.monsters.get(i)!=null) ) {
      attackingCards.set(0, i);
    }
  }
  if ( (mouseX>430) & (mouseX<526) & (mouseY>360) & (mouseY<458) ) {
    attackingCards.set(0, -1);
  }

  //-------------------------------SETTING TARGET
  for (int i=0; i<7; i++) {
    if ( (mouseX>242+70*i) & (mouseX<292+70*i) & (mouseY>185) & (mouseY<235) & (chris.monsters.get(i)!=null) ) {
      attackingCards.set(1, i);
    }
    if ( (mouseX>428)& (mouseX<528)& (mouseY>50) &(mouseY<153)) {
      attackingCards.set(1, -1);
    }
  }
  if (spellMode) {
    if (p1turn) {
      spellTargeting.set(1, attackingCards.get(1));
      if (whichImage<nicolas.size()) {
        if (nicolas.currentHand.get(whichImage).type==1) {
          spellTargeting.set(0, whichImage);
        }
      }
    }
    if (p2turn) {
      spellTargeting.set(0, attackingCards.get(0));
      if (whichImage>=nicolas.size()) {
        if (chris.currentHand.get(whichImage-nicolas.size()).type==1) {
          spellTargeting.set(1, whichImage);
        }
      }
    }
  }
}

void keyPressed() {
  if (key==ENTER) {
    if (spellMode) {
      if (spellTargeting.get(0)!=null & spellTargeting.get(1)!=null) {
        System.out.println(spellTargeting);
        int att = spellTargeting.get(0);
        int rec = spellTargeting.get(1);
        if (p1turn) {
          Card spellAtt = nicolas.currentHand.get(att);
          if (spellAtt.cost <= nicolas.currentMP) {
            if (rec==-1) {
              chris=spellAtt.attackPlayer(chris);
              nicolas.decMP(spellAtt.cost);
              nicolas.currentHand.remove(att);
              images.remove(att);
              image1.remove(att);
              positions.remove(2*att);
              positions.remove(2*att);
            } else {
              Card spellTar = chris.monsters.get(rec);
              chris.monsters.set(rec, attackMonster(spellAtt, spellTar));
              nicolas.decMP(spellAtt.cost);
              nicolas.currentHand.remove(att);
              images.remove(att);
              image1.remove(att);
              positions.remove(2*att);
              positions.remove(2*att);
            }
          } else {
            System.out.println("Not enough MP for spell");
          }
        }
        if (p2turn) {
          Card spellAtt = chris.currentHand.get(rec-nicolas.size());
          if (spellAtt.cost <= chris.currentMP) {
            if (att==-1) { // -1 index refers to other player
              nicolas=spellAtt.attackPlayer(nicolas);
              chris.decMP(spellAtt.cost);
              chris.currentHand.remove(rec-nicolas.size());
              images.remove(rec);
              image1.remove(rec);
              positions.remove(2*rec);
              positions.remove(2*rec);
            } else {
              Card spellTar = nicolas.monsters.get(att);
              nicolas.monsters.set(rec, attackMonster(spellAtt, spellTar));
              chris.decMP(spellAtt.cost);
              chris.currentHand.remove(rec-nicolas.size());
              images.remove(rec);
              image1.remove(rec);
              positions.remove(2*rec);
              positions.remove(2*rec);
            }
          } else {
            System.out.println("Not enough MP for spell");
          }
        }
      } else {
        System.out.println("Target or Spell not loaded properly");
      }
    } 
    else { //monster vs monster/player, no spells or weapons
      if (attackingCards.get(0)!=null & attackingCards.get(1)!=null) {
        int att = attackingCards.get(0);
        int rec = attackingCards.get(1);
        //----------------------p1turn--------------
        if (p1turn) {
          if (att==-1 & rec ==-1) { //player vs player w/ weapon
            if (nicolas.weapon.attackedthisTurn==false) {
              nicolas.weapon.attackPlayer(chris);
              nicolas.weapon.attackedthisTurn=true;
              nicolas.weapon.decHP(1);}
              else {
                System.out.println("Already attacked this turn");
              }
          }
          if (att==-1 & rec !=-1) {// player vs monster
            if (nicolas.weapon.attackedthisTurn==false) {
              int recDamage= chris.monsters.get(rec).value;
              chris.currentHand.set(rec, attackMonster(nicolas.weapon, chris.currentHand.get(rec)));
              nicolas.weapon.attackedthisTurn=true;
              nicolas.weapon.decHP(1);
              nicolas.decHP(recDamage);
            } 
            else {
            System.out.println("Already attacked this turn");
            }
          }
          if (att!=-1 & rec ==-1) {//monster vs player
            if (nicolas.monsters.get(att).attackedthisTurn==false) {
              chris=nicolas.monsters.get(att).attackPlayer(chris);
              nicolas.monsters.get(att).attackedthisTurn=true;
            } else {
              System.out.println("Already attacked this turn");
            }
          } 
          if (att!=-1 & rec ==-1) {//monster vs monster
            if (nicolas.monsters.get(att).attackedthisTurn==false) { // monster vs monster
            int recDamage= chris.monsters.get(rec).value;
            Card placeholder = attackMonster(nicolas.monsters.get(att), chris.monsters.get(rec));
            chris.monsters.set(rec, placeholder);
            if (nicolas.monsters.get(att).currentHP<=recDamage) {
              nicolas.monsters.set(att, null);
            } 
            else {
              nicolas.monsters.get(att).attackedthisTurn=true;
              nicolas.monsters.get(att).currentHP-=recDamage;
            }
            }
          }
        }
        //-------------------------end of p1turn, start of p2turn-----------------------------
        if (p2turn) {
            if (att==-1 & rec ==-1) {} // player vs player w/ weapon
            if (att==-1 & rec !=-1) {
              if (chris.weapon.attackedthisTurn==false) {
                int recDamage= nicolas.monsters.get(att).value;
                nicolas.currentHand.set(att, attackMonster(chris.weapon, nicolas.currentHand.get(att)));
                chris.weapon.attackedthisTurn=true;
                chris.weapon.decHP(1);
                chris.decHP(recDamage);
              } 
              else {
                System.out.println("Already attacked this turn");} // player vs monster
            }
            if (att!=-1 & rec ==-1) {
              if (chris.monsters.get(rec).attackedthisTurn==false) {
              nicolas=chris.monsters.get(rec).attackPlayer(nicolas);
              chris.monsters.get(rec).attackedthisTurn=true;
               } else {
              System.out.println("Already attacked this turn");}
            }//monster vs player
            if (att!=-1 & rec !=-1) {} //monster vs monster
          }
        }
        else {
          System.out.println("Target or Monster not loaded properly");}
    }
        attackingCards.set(0, null);
        attackingCards.set(1, null);
        spellTargeting.set(0, null);
        spellTargeting.set(1, null);
        }
      if (key=='s' || key=='S') {
        spellMode=!spellMode;
        System.out.println("Spell mode is " + spellMode);
      }
      if (key=='t' || key=='T') {
        System.out.println("Nicolas " + nicolas.hpLine());
        System.out.println("Chris " + chris.hpLine());
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

    void displayMana(Player n, int placement) {
      for (int i=0; i < n.maxMP; i++) {
        if (i<n.currentMP) {
          image(loadImage("Cards/ManaCrystal.png"), 600 + 25*i, placement, 25, 25);
        } else {
          image(loadImage("Cards/DarkManaCrystal.png"), 600 + 25*i, placement, 25, 25);
        }
      }
    }
    //960,540

    void fill() {
      //-----------------------------------nicolas's deck-----------------------------------------
      nicolas.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
      nicolas.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
      nicolas.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
      nicolas.deck.add(new Card(loadImage("Cards/BootyBayBodyGuard.jpg"), "Cards/BootyBayBodyGuard.jpg"));
      /*nicolas.deck.add(new Card(loadImage("Cards/BoulderfistOgre.jpg"), "Cards/BoulderfistOgre.jpg"));
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
       nicolas.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));*/

      //-----------------------------------Shaman Cards-----------------------------------------
      /*nicolas.deck.add(new Card(loadImage("Shaman/AlAkir.jpg"), "Shaman/AlAkir.jpg"));
       nicolas.deck.add(new Card(loadImage("Shaman/AncestralKnowledge.jpg"), "Shaman/AncestralKnowledge.jpg"));
       nicolas.deck.add(new Card(loadImage("Shaman/Bloodlust.jpg"), "Shaman/Bloodlust.jpg"));
       nicolas.deck.add(new Card(loadImage("Shaman/Doomhammer.jpg"), "Shaman/Doomhammer.jpg"));
       nicolas.deck.add(new Card(loadImage("Shaman/DustDevil.jpg"), "Shaman/DustDevil.jpg"));
       nicolas.deck.add(new Card(loadImage("Shaman/EarthElemental.jpg"), "Shaman/EarthElemental.jpg"));*/
      nicolas.deck.add(new Card(loadImage("Shaman/ElementalDestruction.png"), "Shaman/ElementalDestruction.png"));
      /*nicolas.deck.add(new Card(loadImage("Shaman/FeralSpirit.jpg"), "Shaman/FeralSpirit.jpg"));
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
       nicolas.deck.add(new Card(loadImage("Shaman/Stormcrack.jpg"), "Shaman/Stormcrack.jpg"));*/
      nicolas.deck.add(new Card(loadImage("Shaman/StormforgedAxe.jpg"), "Shaman/StormforgedAxe.jpg"));
      //nicolas.deck.add(new Card(loadImage("Shaman/TotemGolem.jpg"), "Shaman/TotemGolem.jpg"));

      //-----------------------------------chris's deck-----------------------------------------

      chris.deck.add(new Card(loadImage("Cards/AcidicSwampOoze.jpg"), "Cards/AcidicSwampOoze.jpg"));
      chris.deck.add(new Card(loadImage("Cards/BloodfenRaptor.jpg"), "Cards/BloodfenRaptor.jpg"));
      chris.deck.add(new Card(loadImage("Cards/BluegillWarrior.png"), "Cards/BluegillWarrior.png"));
      /*chris.deck.add(new Card(loadImage("Cards/BootyBayBodyGuard.jpg"), "Cards/BootyBayBodyGuard.jpg"));
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
       chris.deck.add(new Card(loadImage("Cards/Wolfrider.jpg"), "Cards/Wolfrider.jpg"));*/

      //-----------------------------------Paladin Cards-----------------------------------------
      /*chris.deck.add(new Card(loadImage("Paladin/AldorPeacekeeper.jpg"), "Paladin/AldorPeacekeeper.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/BlessedChampion.jpg"), "Paladin/BlessedChampion.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/BlessingOfKings.jpg"), "Paladin/BlessingOfKings.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/BlessingOfMight.png"), "Paladin/BlessingOfMight.png")); */
      chris.deck.add(new Card(loadImage("Paladin/Consecration.jpg"), "Paladin/Consecration.jpg"));
      /*chris.deck.add(new Card(loadImage("Paladin/Dinosize.jpg"), "Paladin/Dinosize.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/DivineStrength.jpg"), "Paladin/DivineStrength.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/EadricThePure.jpg"), "Paladin/EadricThePure.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/Equality.jpg"), "Paladin/Equality.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/ForbiddenHealing.jpg"), "Paladin/ForbiddenHealing.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/GuardianOfKings.jpg"), "Paladin/GuardianOfKings.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/HammerOfWrath.jpg"), "Paladin/HammerOfWrath.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/HolyLight.png"), "Paladin/HolyLight.png"));
       chris.deck.add(new Card(loadImage("Paladin/Humility.png"), "Paladin/Humility.png"));
       chris.deck.add(new Card(loadImage("Paladin/KeeperOfUldaman.png"), "Paladin/KeeperOfUldaman.png"));
       chris.deck.add(new Card(loadImage("Paladin/LayOnHands.jpg"), "Paladin/LayOnHands.jpg"));*/
      chris.deck.add(new Card(loadImage("Paladin/LightsJustice.jpg"), "Paladin/LightsJustice.jpg"));
      /*chris.deck.add(new Card(loadImage("Paladin/LostInTheJungle.jpg"), "Paladin/LostInTheJungle.jpg"));
       //chris.deck.add(new Card(loadImage("Paladin/SealOfLight.png"), "Paladin/SealOfLight.png"));
       chris.deck.add(new Card(loadImage("Paladin/StandAgainstDarkness.jpg"), "Paladin/StandAgainstDarkness.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/SunkeeperTarim.jpg"), "Paladin/SunkeeperTarim.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/Tirion.jpg"), "Paladin/Tirion.jpg"));
       chris.deck.add(new Card(loadImage("Paladin/TruesilverChampion.jpg"), "Paladin/TruesilverChampion.jpg*/
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
    
    int CardOverWep1() {
      for (int j=0; j < images.size()*2; j+=2) {
        if ((positions.get(j) > 331) && (positions.get(j)< 389) && (positions.get(j+1)> 366) && (positions.get(j+1)<424)) {
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
    
    int CardOverWep2() {
      for (int j=0; j < images.size()*2; j+=2) {
        if ((positions.get(j) > 331) && (positions.get(j)< 389) && (positions.get(j+1)> 66) && (positions.get(j+1)<124)) {
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
        Card card1=new Card(image1.get(index1), images.get(index1));
        if ((card1.cost <=nicolas.currentMP) & (card1.type==0)) 
        {
          nicolas.addMonster(0, card1);
          nicolas.currentHand.remove(index1);
          images.remove(index1);
          image1.remove(index1);
          positions.remove(2*index1);
          positions.remove(2*index1);
          nicolas.decMP(card1.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }

      int index2 = CardOver2();
      if (index2 != -1) {
        Card card2=new Card(image1.get(index2), images.get(index2));
        if ((card2.cost <=nicolas.currentMP) & (card2.type==0))
        {
          nicolas.addMonster(1, card2);
          nicolas.currentHand.remove(index2);
          images.remove(index2);
          image1.remove(index2);
          positions.remove(2*index2);
          positions.remove(2*index2);
          nicolas.decMP(card2.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }

      int index3 = CardOver3();
      if (index3 != -1) {
        Card card3=new Card(image1.get(index3), images.get(index3));
        if ((card3.cost <=nicolas.currentMP) & (card3.type==0))
        {
          nicolas.addMonster(2, card3);
          nicolas.currentHand.remove(index3);
          images.remove(index3);
          image1.remove(index3);
          positions.remove(2*index3);
          positions.remove(2*index3);
          nicolas.decMP(card3.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }  
      int index4 = CardOver4();
      if (index4 != -1) {
        Card card4=new Card(image1.get(index4), images.get(index4));
        if ((card4.cost <=nicolas.currentMP) & (card4.type==0))
        {
          nicolas.addMonster(3, card4);
          nicolas.currentHand.remove(index4);
          images.remove(index4);
          image1.remove(index4);
          positions.remove(2*index4);
          positions.remove(2*index4);
          nicolas.decMP(card4.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }  
      int index5 = CardOver5();
      if (index5 != -1) {
        Card card5=new Card(image1.get(index5), images.get(index5));
        if ((card5.cost <=nicolas.currentMP) & (card5.type==0))
        {
          nicolas.addMonster(4, card5);
          nicolas.currentHand.remove(index5);
          images.remove(index5);
          image1.remove(index5);
          positions.remove(2*index5);
          positions.remove(2*index5);
          nicolas.decMP(card5.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }  

      int index6 = CardOver6();
      if (index6 != -1) {
        Card card6=new Card(image1.get(index6), images.get(index6));
        if ((card6.cost <=nicolas.currentMP) & (card6.type==0))
        {
          nicolas.addMonster(5, card6);
          nicolas.currentHand.remove(index6);
          images.remove(index6);
          image1.remove(index6);
          positions.remove(2*index6);
          positions.remove(2*index6);
          nicolas.decMP(card6.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }  

      int index7 = CardOver7();
      if (index7 != -1) {
        Card card7=new Card(image1.get(index7), images.get(index7));
        if ( (card7.cost <=nicolas.currentMP) & (card7.type==0))
        {
          nicolas.addMonster(6, card7);
          nicolas.currentHand.remove(index7);
          images.remove(index7);
          image1.remove(index7);
          positions.remove(2*index7);
          positions.remove(2*index7);
          nicolas.decMP(card7.cost);
        } 
        else {
          System.out.println("Could not process card: either not enough mana or not a monster");
        }
      }
      
      int indexWep1 = CardOverWep1();
      if (indexWep1 != -1) {
        Card cardWep1=new Card(image1.get(indexWep1), images.get(indexWep1));
        if ( (cardWep1.cost <=nicolas.currentMP) & (cardWep1.type==2) )
        {
          nicolas.weapon=cardWep1;
          nicolas.currentHand.remove(indexWep1);
          images.remove(indexWep1);
          image1.remove(indexWep1);
          positions.remove(2*indexWep1);
          positions.remove(2*indexWep1);
          nicolas.decMP(cardWep1.cost);
        } else {
          System.out.println("Could not process card: either not enough mana or not a weapon");
        }
      }
        
    }
    //----------------------END OF BOTTOM PLAYER PROCESS----------------------------------
    //----------------------TOP PLAYER PROCESS----------------------------------
    void processCards2() {
      int index8 = CardOver8();
      if (index8 != -1) {
        Card card8=new Card(image1.get(index8), images.get(index8));
        if ((card8.cost <=chris.currentMP) & (card8.type==0))
        {
          chris.addMonster(0, card8);
          index8-=nicolas.size();
          chris.currentHand.remove(index8);
          index8+=nicolas.size();
          images.remove(index8);
          image1.remove(index8);
          positions.remove(2*index8);
          positions.remove(2*index8);
          chris.decMP(card8.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }

      int index9 = CardOver9();
      if (index9 != -1) {
        Card card9=new Card(image1.get(index9), images.get(index9));
        if ((card9.cost <=chris.currentMP) & (card9.type==0))
        {
          chris.addMonster(1, card9);
          index9-=nicolas.size();
          chris.currentHand.remove(index9);
          index9+=nicolas.size();
          images.remove(index9);
          image1.remove(index9);
          positions.remove(2*index9);
          positions.remove(2*index9);
          chris.decMP(card9.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      int index10 = CardOver10();
      if (index10 != -1) {
        Card card10=new Card(image1.get(index10), images.get(index10));
        if ((card10.cost <=chris.currentMP) & (card10.type==0))
        {
          chris.addMonster(2, card10);
          index10-=nicolas.size();
          chris.currentHand.remove(index10);
          index10+=nicolas.size();
          images.remove(index10);
          image1.remove(index10);
          positions.remove(2*index10);
          positions.remove(2*index10);
          chris.decMP(card10.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      int index11 = CardOver11();
      if (index11 != -1) {
        Card card11=new Card(image1.get(index11), images.get(index11));
        if ((card11.cost <=chris.currentMP) & (card11.type==0))
        {
          chris.addMonster(3, card11);
          index11-=nicolas.size();
          chris.currentHand.remove(index11);
          index11+=nicolas.size();
          images.remove(index11);
          image1.remove(index11);
          positions.remove(2*index11);
          positions.remove(2*index11);
          chris.decMP(card11.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      int index12 = CardOver12();
      if (index12 != -1) {
        Card card12=new Card(image1.get(index12), images.get(index12));
        if ((card12.cost <=chris.currentMP) & (card12.type==0))
        {
          chris.addMonster(4, card12);
          index12-=nicolas.size();
          chris.currentHand.remove(index12);
          index12+=nicolas.size();
          images.remove(index12);
          image1.remove(index12);
          positions.remove(2*index12);
          positions.remove(2*index12);
          chris.decMP(card12.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      int index13 = CardOver13();
      if (index13 != -1) {
        Card card13=new Card(image1.get(index13), images.get(index13));
        if ((card13.cost <=chris.currentMP) & (card13.type==0))
        {
          chris.addMonster(0, card13);
          index13-=nicolas.size();
          chris.currentHand.remove(index13);
          index13+=nicolas.size();
          images.remove(index13);
          image1.remove(index13);
          positions.remove(2*index13);
          positions.remove(2*index13);
          chris.decMP(card13.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      int index14 = CardOver14();
      if (index14 != -1) {
        Card card14=new Card(image1.get(index14), images.get(index14));
        if ((card14.cost <=chris.currentMP) & (card14.type==0))
        {
          chris.addMonster(0, card14);
          index14-=nicolas.size();
          chris.currentHand.remove(index14);
          index14+=nicolas.size();
          images.remove(index14);
          image1.remove(index14);
          positions.remove(2*index14);
          positions.remove(2*index14);
          chris.decMP(card14.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a monster");
        }
      }
      
      int indexWep2 = CardOverWep2();
      if (indexWep2 != -1) {
        Card cardWep2=new Card(image1.get(indexWep2), images.get(indexWep2));
        if ( (cardWep2.cost <=chris.currentMP) & (cardWep2.type==2) )
        {
          chris.weapon=cardWep2;
          indexWep2-=nicolas.size();
          chris.currentHand.remove(indexWep2);
          indexWep2+=nicolas.size();
          images.remove(indexWep2);
          image1.remove(indexWep2);
          positions.remove(2*indexWep2);
          positions.remove(2*indexWep2);
          chris.decMP(cardWep2.cost);
        } else {
          System.out.println("Not enough mana to process card: either not enough mana or not a weapon");
        }
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
      if (nicolas.weapon!=null) {
        PImage b = loadImage(nicolas.weapon.path);
      image(b, 360, 395, 50, 50);
      nicolas.weapon.shown=true;
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
      if (chris.weapon!=null) {
        PImage b = loadImage(chris.weapon.path);
      image(b, 360, 95, 50, 50);
      chris.weapon.shown=true;
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
      if (attackingCards.get(0)!=null) {
        if (attackingCards.get(0)==-1) {
          fill(255, 0, 0);
          rect(426, 356, 104, 4);
          rect(426, 458, 104, 4); 
          rect(426, 360, 4, 98);
          rect(526, 360, 4, 98);
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
      if (attackingCards.get(1)!=null) {
        if (attackingCards.get(1)==-1) {
          fill(0, 255, 0);
          rect(424, 46, 108, 4);
          rect(424, 153, 108, 4); 
          rect(424, 50, 4, 103);
          rect(528, 50, 4, 103);
        }
      }
    }

    void fillSpellCard() {
      if (p1turn) {
        if (spellTargeting.get(0)!=null) {
          int borderStart=10+80*(spellTargeting.get(0));
          fill(255, 255, 0);
          rect(borderStart-4, 466, 58, 4);
          rect(borderStart-4, 520, 58, 4);
          rect(borderStart-4, 470, 4, 50);
          rect(borderStart+50, 470, 4, 50);
        }
      }
      if (p2turn) {
        if (spellTargeting.get(1)!=null) {
          int borderStart=10+80*(spellTargeting.get(1)-nicolas.size());
          fill(255, 255, 0);
          rect(borderStart-4, 16, 58, 4);
          rect(borderStart-4, 70, 58, 4);
          rect(borderStart-4, 20, 4, 50);
          rect(borderStart+50, 20, 4, 50);
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