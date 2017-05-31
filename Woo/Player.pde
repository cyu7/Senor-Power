class Player {
  int HP; //max 30
  int MP; //current MP
  int maxMP; //max 10
  ArrayList<Card> currentHand; //max 10
  ArrayList<Card> deck; //max 30
  ArrayList<Card> monsters; //max 7

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