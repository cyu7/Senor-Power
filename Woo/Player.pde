class Player{
 int HP; //max 30
 int MP; //current MP
 int maxMP; //max 10
 ArrayList<Card> currentHand; //max 10
 ArrayList<Card> deck; //max 30
 ArrayList<Card> monsters; //max 7
  
  //draw a card
  void draw() {
  egg = loadImage("Cards/Wolfrider.jpg");
    Card icon = new Card(egg, "Cards/Wolfrider.jpg");
    Card icon2 = new Card(egg, "Cards/Wolfrider.jpg");
    Card icon3 = new Card(egg, "Cards/Wolfrider.jpg");
    deck.add(icon);
    deck.add(icon2);
    deck.add(icon3);
    currentHand.add(deck.get(0));
    deck.remove(0);
    currentHand.add(deck.get(0));
    deck.remove(0);
    currentHand.add(deck.get(0));
    deck.remove(0);
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
