class Player{
 int HP; //max 30
 int MP; //max = maxMP
 int maxMP; //max 10
 ArrayList<Card> currentHand; //max 10
 ArrayList<Card> deck; //max 30
 Card[] monsters; //max 7
  
  //draw a card
  void draw() {
  }
  
  //increase HP
  void incHP(int value) {
   HP += value; 
  }
  
  //decrease HP
  void decHP(int value) {
   HP -= value; 
  }
  
  //increase MP
  void incMP() {
   maxMP++;
   MP = maxMP;
  }
  
  //decrease MP
  void decMP(int value) {
    MP -= value;
  }
  
  //add monster
  void addMonster() {
    
  }
}