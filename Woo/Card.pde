class Card{
  enum CardType; //Monster, Spell, Weapon
  int value; //damage
  int currentHP; //current health
  int maxHP; //max health
  int cost; //mana cost
  
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
}