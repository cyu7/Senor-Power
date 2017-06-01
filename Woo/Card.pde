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
    //-----------------------------------Paladin Cards-----------------------------------------
    if (paf.equals("Paladin/AldorPeacekeeper.jpg"))
    {
      cost = 3;
      value = 3;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Paladin/Ashbringer.png"))
    {
      cost = 5;
      value = 5;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Paladin/BlessedChampion.jpg"))
    {
      cost = 5;
      //Doubles attack and hp of a monster
    }
    if (paf.equals("Paladin/BlessingOfKings.jpg"))
    {
      cost = 4;
      //+4 attack and hp
    }
    if (paf.equals("Paladin/BlessingOfMight.png"))
    {
      cost = 1;
      //+3 attack
    }
    if (paf.equals("Paladin/Consecration.jpg"))
    {
      cost = 4;
      //Deal 2 damage to all enemy monsters
    }
    if (paf.equals("Paladin/Dinosize.jpg"))
    {
      cost = 8;
      //Change attack and hp to 10
    }
    if (paf.equals("Paladin/DivineStrength.jpg"))
    {
      cost = 1;
      //+1 attack, +2 hp
    }
    if (paf.equals("Paladin/Equality.jpg"))
    {
      cost = 2;
      //Change hp of all monsters to 1
    }
    if (paf.equals("Paladin/ForbiddenHealing.jpg"))
    {
      cost = 0;
      //Spend all of your current mana and heal 2x that amount
    }
    if (paf.equals("Paladin/GuardianOfKings.jpg"))
    {
      cost = 7;
      value = 5;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Paladin/HammerOfWrath.jpg"))
    {
      cost = 4;
      value = 3;
      //Deal 3 damage to monster/player and draw a card
    }
    if (paf.equals("Paladin/HolyLight.png"))
    {
      cost = 2;
      //Heal 6 hp to a monster/player
    }
    if (paf.equals("Paladin/Humility.png"))
    {
      cost = 1;
      //Change a monster's attack to 1
    }
    if (paf.equals("Paladin/KeeperOfWuldaman.png"))
    {
      cost = 4;
      value = 3;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Paladin/LayOnHands.jpg"))
    {
      cost = 8;
      //Heal 8 hp to a monster/player and draw 3 cards
    }
    if (paf.equals("Paladin/LightsJustice.jpg"))
    {
      cost = 1;
      value = 1;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Paladin/LostInTheJungle.jpg"))
    {
      cost = 1;
      //Summon 2 SilverHandRecruit
    }
    if (paf.equals("Paladin/SilverHandRecruit.png"))
    {
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Paladin/StandAgainstDarkness.jpg"))
    {
      cost = 5;
      //Summon 5 SilverHandRecruit
    }
    if (paf.equals("Paladin/SunkeeperTarim.jpg"))
    {
      cost = 6;
      value = 3;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Paladin/Tirion.jpg"))
    {
      cost = 8;
      value = 6;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Paladin/TruesilverChampion.jpg"))
    {
      cost = 4;
      value = 4;
      currentHP = 2;
      maxHP = 2;
    }
    //-----------------------------------Shaman Cards-----------------------------------------
    if (paf.equals("Shaman/AirTotem.jpg"))
    {
      cost = 1;
      value = 0;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Shaman/AlAkir.jpg"))
    {
      cost = 8;
      value = 3;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Shaman/AncestralKnowledge.jpg"))
    {
      cost = 2;
      //Draw 2 cards, overload 2 mana
    }
    if (paf.equals("Shaman/Bloodlust.jpg"))
    {
      cost = 5;
      //All your monsters have +3 attack this turn only
    }
    if (paf.equals("Shaman/Doomhammer.jpg"))
    {
      cost = 5;
      value = 2;
      currentHP = 8;
      maxHP = 8;
    }
    if (paf.equals("Shaman/DustDevil.jpg"))
    {
      cost = 1;
      value = 3;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Shaman/EarthElemental.jpg"))
    {
      cost = 5;
      value = 7;
      currentHP = 8;
      maxHP = 8;
    }
    if (paf.equals("Shaman/ElementalDestruction.png"))
    {
      cost = 3;
      //Deal 4 or 5 damage to all monsters, overload 5 mana
    }
    if (paf.equals("Shaman/FeralSpirit.jpg"))
    {
      cost = 2;
      //Summon 2 SpiritWolf, overload 2 mana
    }
    if (paf.equals("Shaman/FireElemental.jpg"))
    {
      cost = 6;
      value = 6;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Shaman/FlamewreathedFaceless.jpg"))
    {
      cost = 4;
      value = 7;
      currentHP = 7;
      maxHP = 7;
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