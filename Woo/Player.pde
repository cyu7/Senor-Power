class Player {
  int maxHP; //max 30
  int currentHP; //max 30
  int currentMP; //current MP
  int maxMP; //max 10
  int deckDamage=1; //damage taken if there are no more cards to draw
  ArrayList<Card> currentHand; //max 10
  ArrayList<Card> deck; //max 30
  ArrayList<Card> monsters; //max 7
  Card weapon;
  boolean usedHeroPower;

  Player() {
    maxHP = 30;
    currentHP = 30;
    currentMP = 1;
    maxMP = 1;
    deckDamage = 1;
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
        System.out.println("Current hand too full");
      }
      if (currentHand.size()<10) {
        currentHand.add(deck.remove((int) random(deck.size())));
      }
    }
    else {
      System.out.println("You took " + deckDamage + " damage because there are no cards left in your deck!");
      decHP(deckDamage);
      deckDamage++;
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
      {currentMP = maxMP;}}
      else {
        if (currentMP<10)
      {currentMP = maxMP;}}
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
    
    String mpLine() {
      return "MP: " + currentMP + "/" + maxMP;
    }

    //add monster
    void addMonster(int n, Card monster) {
      monsters.set(n, monster);
      monsters.get(n).shown=false;
    } 

    String toString() {
      String result="";
      result += "\n"+ hpLine();
      result += "\n"+ mpLine();
      if (weapon!=null) {
        result+= "\n\nWeapon Damage: " + weapon.value;
        result+= "\nWeapon Durability: " + weapon.currentHP;
      }
      else {
        result += "\nNo Weapon";}
     result += "\n-----------------------";
     return result;   
    }
}