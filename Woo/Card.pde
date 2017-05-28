class Card{
  PImage picture; //icon
  String path; //directory path
  Type card; //Monster, Spell, Weapon
  int value; //damage
  int currentHP; //current health
  int maxHP; //max health
  int cost; //mana cost
  boolean shown=false;
  
  //default constructor
   Card(PImage portrait, String paf) {
    picture = portrait;
    path = paf;
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
   if( (currentHP + value) >= maxHP){
    currentHP = maxHP;
   }
   else{
    currentHP += value;
   }
  }
  
  //decrease HP
  void decHP(int value) {
    if( (currentHP - value) <= 0){
     currentHP = 0; 
    }
    else{
     currentHP -= value; 
    }
  }
 
  
  String toString() { 
     return path;
  }
}