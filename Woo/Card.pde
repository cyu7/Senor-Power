class Card {
  PImage picture; //icon
  String path; //directory path
  Type card; //Monster, Spell, Weapon
  int value; //damage
  int currentHP; //current health
  int maxHP; //max health
  int cost; //mana cost
  boolean shown=false;
  boolean attackedthisTurn=false;

  //default constructor
  Card(PImage portrait, String paf) {
    picture = portrait;
    path = paf;
    if (paf.equals("Cards/AcidicSwampOoze.jpg"))
    {    
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BloodfenRaptor.jpg"))
    {
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BluegillWarrior.png"))
    {
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BootyBayBodyGuard.jpg"))
    {
      cost = 4;
      value = 5;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/BoulderfistOgre.jpg"))
    {
      cost = 6;
      value = 6;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/ChillwindYeti.png"))
    {
      cost = 4;
      value = 4;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/ElvenArcher.jpg"))
    {
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/FrostwolfGrunt.jpg"))
    {
      cost = 2;
      value = 2;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/GnomishInventor.jpg"))
    {
      cost = 4;
      value = 2;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/GoldshireFootman.png"))
    {
      cost = 1;
      value = 1;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/Nightblade.jpg"))
    {
      cost = 5;
      value = 4;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/NoviceEngineer.jpg"))
    {
      cost = 2;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/OasisSnapjaw.jpg"))
    {
      cost = 4;
      value = 2;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/RecklessRocketeer.jpg"))
    {
      cost = 6;
      value = 5;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/RiverCrocolisk.png"))
    {
      cost = 2;
      value = 2;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Cards/SenjinShieldmaster.jpg"))
    {
      cost = 4;
      value = 3;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/StonetuskBoar.jpg"))
    {
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/StormpikeCommando.jpg"))
    {
      cost = 5;
      value = 4;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/StormwindKnight.jpg"))
    {
      cost = 4;
      value = 2;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/VoodooDoctor.jpg"))
    {
      cost = 1;
      value = 2;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/WarGolem.jpg"))
    {
      cost = 7;
      value = 7;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/Wolfrider.jpg"))
    {
      cost = 3;
      value = 3;
      currentHP = 1;
      maxHP = 1;
    }
  }

  //overloaded constructor
  Card(PImage portrait, String paf, int damage, int HP, int mana) {
    picture = portrait;
    path = paf;
    value = damage;
    currentHP = HP;
    maxHP = HP;
    cost = mana;
  }
  //increase HP
  void incHP(int value) {
    if ( (currentHP + value) >= maxHP) {
      currentHP = maxHP;
    } else {
      currentHP += value;
    }
  }

  //decrease HP
  void decHP(int value) {
    if ( (currentHP - value) <= 0) {
      currentHP = 0;
    } else {
      currentHP -= value;
    }
  }
  
  Card attackMonster(Card attacker, Card receiver) {
    receiver.currentHP-=attacker.value;
    if (receiver.currentHP>0) {
    return receiver;}
    else {
      return null;
  }
  }
  

  String toString() { 
    String result = path.substring(6,path.length()-4);
    result += "\nHP: " + currentHP + "/" + maxHP;
    result += "\nCost: " + cost;
    result += "\nDamage: " + value;
    return result;
  }
}