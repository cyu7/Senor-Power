class Player {
  int maxHP; //max 30
  int currentHP; //max 30
  int currentMP; //current MP
  int maxMP; //max 10
  ArrayList<Card> currentHand; //max 10
  ArrayList<Card> deck; //max 30
  ArrayList<Card> monsters; //max 7

  Player() {
    maxHP = 30;
    currentHP = 30;
    currentMP = 1;
    maxMP = 1;
    currentHand = new ArrayList<Card>();
    deck = new ArrayList<Card>();
    monsters = new ArrayList<Card>();
    for (int i=0; i<7; i++) {
      monsters.add(null);
    }
  }

  int size() {
    return currentHand.size();
  }

  //draw a card
  void drawCard() {
    if (deck.size()>0) {
      if (currentHand.size()>=10) {
        deck.remove((int) random(deck.size()));
      }
      if (currentHand.size()<10) {
        currentHand.add(deck.remove((int) random(deck.size())));
      } 
      if (deck.size()==0) {
        System.out.println("No more cards");
      }
    }
  }


    //increase HP
    void incHP(int value) {
      currentHP += value;
    }

    //decrease HP
    void decHP(int value) {
      currentHP -= value;
      if (currentHP<0) {
        currentHP=0;
      }
    }

    //increase MP
    void incMP() {
      if (maxMP<10)
      {maxMP++;
      if (currentMP<10)
      {currentMP += 1;}}
      else {
        if (currentMP<10)
      {currentMP += 1;}}
    }

    //decrease MP
    void decMP(int value) {
      currentMP -= value;
      if (currentMP <0) {
        currentMP=0;
    }
    }
    
    String hpLine() {
      return "HP: " + currentHP + "/" + maxHP;
    }

    //add monster
    void addMonster(int n, Card monster) {
      monsters.set(n, monster);
      monsters.get(n).shown=false;
    } 

    //void clearDead {
    //for int 

    //attacking a monster
    /*void attackMonster(int attackerIndex, int receiverIndex, int damage){
     
     }*/

    //attacking a player
    /*void attackDir(int damage){
     
     }*/
  }