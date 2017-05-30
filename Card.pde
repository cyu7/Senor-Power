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
    if (paf.equals("Cards/Wolfrider.jpg"))
    {
      cost=3;
      value = 3;
      currentHP=1;
      maxHP=1;
    }
    if (paf.equals("Cards/AcidicSwampOoze.jpg"))
    {    
      cost=2;
      value = 3;
      currentHP=2;
      maxHP=2;
    }
    if (paf.equals("Cards/BloodfenRaptor.jpg"))
    {
      cost=2;
      value = 3;
      currentHP=2;
      maxHP=2;
    }
    if (paf.equals("Cards/BluegillWarrior.png"))
    {
      cost=2;
      value = 3;
      currentHP=2;
      maxHP=2;
    }
    if (paf.equals("Cards/Nightblade.jpg"))
    {
      cost=5;
      value = 4;
      currentHP=4;
      maxHP=4;
    }
    if (paf.equals("Cards/NoviceEngineer.jpg"))
    {
      cost=2;
      value = 1;
      currentHP=1;
      maxHP=1;
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