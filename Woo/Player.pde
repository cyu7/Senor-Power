class Player{
 int HP; //max 30
 int MP; //current MP
 int maxMP; //max 10
 ArrayList<Card> currentHand; //max 10
 ArrayList<Card> deck; //max 30
 ArrayList<Card> monsters; //max 7
 PImage egg;
  
  Player() {
    HP = 30;
    MP = 1;
    maxMP = 1;
    currentHand = new ArrayList<Card>();
    deck = new ArrayList<Card>();
    monsters = new ArrayList<Card>();
    for (int i=0; i<7; i++) {
    monsters.add(null);
    }
  }
  
  //draw a card
  void drawCard() {
    currentHand.add(deck.remove((int) random(deck.size())));
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
 /* void addMonster(Card monster) {
    if (monsters.size()<7) {
      monsters.add(monster);
      System.out.println(monsters);
    } else {
      System.out.println("Too many monsters");
    }
  }*/
  
  //attacking a monster
  /*void attackMonster(Card monster,int damage){
    
  }*/

  //attacking a player
  /*void attackDir(int damage){
    
  }*/
}