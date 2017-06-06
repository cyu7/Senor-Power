class Card {
  PImage picture; //icon
  String path; //directory path
  int type; // 0)Monster, 1)Spell, 2)Weapon
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
      type = 0;
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BloodfenRaptor.jpg"))
    {
      type = 0;
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BluegillWarrior.png"))
    {
      type = 0;
      cost = 2;
      value = 3;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/BootyBayBodyGuard.jpg"))
    {
      type = 0;
      cost = 4;
      value = 5;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/BoulderfistOgre.jpg"))
    {
      type = 0;
      cost = 6;
      value = 6;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/ChillwindYeti.png"))
    {
      type = 0;
      cost = 4;
      value = 4;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/ElvenArcher.jpg"))
    {
      type = 0;
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/FrostwolfGrunt.jpg"))
    {
      type = 0;
      cost = 2;
      value = 2;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/GnomishInventor.jpg"))
    {
      type = 0;
      cost = 4;
      value = 2;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/GoldshireFootman.png"))
    {
      type = 0;
      cost = 1;
      value = 1;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/Nightblade.jpg"))
    {
      type = 0;
      cost = 5;
      value = 4;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Cards/NoviceEngineer.jpg"))
    {
      type = 0;
      cost = 2;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/OasisSnapjaw.jpg"))
    {
      type = 0;
      cost = 4;
      value = 2;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/RecklessRocketeer.jpg"))
    {
      type = 0;
      cost = 6;
      value = 5;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/RiverCrocolisk.png"))
    {
      type = 0;
      cost = 2;
      value = 2;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Cards/SenjinShieldmaster.jpg"))
    {
      type = 0;
      cost = 4;
      value = 3;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/StonetuskBoar.jpg"))
    {
      type = 0;
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/StormpikeCommando.jpg"))
    {
      type = 0;
      cost = 5;
      value = 4;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Cards/StormwindKnight.jpg"))
    {
      type = 0;
      cost = 4;
      value = 2;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Cards/VoodooDoctor.jpg"))
    {
      type = 0;
      cost = 1;
      value = 2;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Cards/WarGolem.jpg"))
    {
      type = 0;
      cost = 7;
      value = 7;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Cards/Wolfrider.jpg"))
    {
      type = 0;
      cost = 3;
      value = 3;
      currentHP = 1;
      maxHP = 1;
    }
    //-----------------------------------Paladin Cards-----------------------------------------
    if (paf.equals("Paldn/AldorPeacekeeper.jpg"))
    {
      type = 0;
      cost = 3;
      value = 3;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Paldn/Ashbringer.png"))
    {
      type = 2;
      cost = 5;
      value = 5;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Paldn/BlessedChampion.jpg"))
    {
      type = 1;
      cost = 5;
      //Doubles attack and hp of a monster
    }
    if (paf.equals("Paldn/BlessingOfKings.jpg"))
    {
      type = 1;
      cost = 4;
      //+4 attack and hp
    }
    if (paf.equals("Paldn/BlessingOfMight.png"))
    {
      type = 1;
      cost = 1;
      //+3 attack
    }
    if (paf.equals("Paldn/Consecration.jpg"))
    {
      type = 1;
      cost = 4;
      value = 2;
      //Deal 2 damage to all enemy monsters
    }
    if (paf.equals("Paldn/Dinosize.jpg"))
    {
      type = 1;
      cost = 8;
      //Change attack and hp to 10
    }
    if (paf.equals("Paldn/DivineStrength.jpg"))
    {
      type = 1;
      cost = 1;
      //+1 attack, +2 hp
    }
    if (paf.equals("Paldn/Equality.jpg"))
    {
      type = 1;
      cost = 2;
      //Change hp of all monsters to 1
    }
    if (paf.equals("Paldn/ForbiddenHealing.jpg"))
    {
      type = 1;
      cost = 0;
      //Spend all of your current mana and heal 2x that amount
    }
    if (paf.equals("Paldn/GuardianOfKings.jpg"))
    {
      type = 0;
      cost = 7;
      value = 5;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Paldn/HammerOfWrath.jpg"))
    {
      type = 1;
      cost = 4;
      value = 3;
      //Deal 3 damage to monster/player and draw a card
    }
    if (paf.equals("Paldn/HolyLight.png"))
    {
      type = 1;
      cost = 2;
      //Heal 6 hp to a monster/player
    }
    if (paf.equals("Paldn/Humility.png"))
    {
      type = 1;
      cost = 1;
      //Change a monster's attack to 1
    }
    if (paf.equals("Paldn/KeeperOfWuldaman.png"))
    {
      type = 0;
      cost = 4;
      value = 3;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Paldn/LayOnHands.jpg"))
    {
      type = 1;
      cost = 8;
      //Heal 8 hp to a monster/player and draw 3 cards
    }
    if (paf.equals("Paldn/LightsJustice.jpg"))
    {
      type = 2;
      cost = 1;
      value = 1;
      currentHP = 4;
      maxHP = 4;
    }
    if (paf.equals("Paldn/LostInTheJungle.jpg"))
    {
      type = 1;
      cost = 1;
      //Summon 2 SilverHandRecruit
    }
    if (paf.equals("Paldn/SilverHandRecruit.png"))
    {
      type = 0;
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Paldn/StandAgainstDarkness.jpg"))
    {
      type = 1;
      cost = 5;
      //Summon 5 SilverHandRecruit
    }
    if (paf.equals("Paldn/SunkeeperTarim.jpg"))
    {
      type = 0;
      cost = 6;
      value = 3;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Paldn/Tirion.jpg"))
    {
      type = 0;
      cost = 8;
      value = 6;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Paldn/TruesilverChampion.jpg"))
    {
      type = 2;
      cost = 4;
      value = 4;
      currentHP = 2;
      maxHP = 2;
    }
    //-----------------------------------Shaman Cards-----------------------------------------
    if (paf.equals("Shamn/AirTotem.jpg"))
    {
      type = 0;
      cost = 1;
      value = 0;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Shamn/AlAkir.jpg"))
    {
      type = 0;
      cost = 8;
      value = 3;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Shamn/AncestralKnowledge.jpg"))
    {
      type = 1;
      cost = 2;
      //Draw 2 cards, overload 2 mana
    }
    if (paf.equals("Shamn/Bloodlust.jpg"))
    {
      type = 1;
      cost = 5;
      //All your monsters have +3 attack this turn only
    }
    if (paf.equals("Shamn/Doomhammer.jpg"))
    {
      type = 2;
      cost = 5;
      value = 2;
      currentHP = 8;
      maxHP = 8;
    }
    if (paf.equals("Shamn/DustDevil.jpg"))
    {
      type = 0;
      cost = 1;
      value = 3;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Shamn/EarthElemental.jpg"))
    {
      type = 0;
      cost = 5;
      value = 7;
      currentHP = 8;
      maxHP = 8;
    }
    if (paf.equals("Shamn/ElementalDestruction.png"))
    {
      type = 1;
      cost = 3;
      value = 4;
      //Deal 4 or 5 damage to all monsters, overload 5 mana
    }
    if (paf.equals("Shamn/FeralSpirit.jpg"))
    {
      type = 1;
      cost = 2;
      //Summon 2 SpiritWolf, overload 2 mana
    }
    if (paf.equals("Shamn/FireElemental.jpg"))
    {
      type = 0;
      cost = 6;
      value = 6;
      currentHP = 5;
      maxHP = 5;
    }
    if (paf.equals("Shamn/FlamewreathedFaceless.jpg"))
    {
      type = 0;
      cost = 4;
      value = 7;
      currentHP = 7;
      maxHP = 7;
    }
    if (paf.equals("Shamn/FrostShot.jpg"))
    {
      type = 1;
      cost = 1;
      value = 1;
      //Deal 1 dmg and freeze 
    }
    if (paf.equals("Shamn/Hallazeal.jpg"))
    {
      type = 0;
      cost = 5;
      value = 4;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Shamn/HealingTotem.png"))
    {
      type = 0;
      cost = 1;
      value = 0;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Shamn/JinyuWaterSpeaker.jpg"))
    {
      type = 0;
      cost = 4;
      value = 3;
      currentHP = 6;
      maxHP = 6;
    }
    if (paf.equals("Shamn/LavaBurst.jpg"))
    {
      type = 1;
      cost = 3;
      value = 5;
      //Deal 5 damage and overload 2
    }
    if (paf.equals("Shamn/LightningStorm.jpg"))
    {
      type = 1;
      cost = 3;
      value = 2;
      //Deal 2 or 3 dmg to all enemy monsters and overload 2
    }
    if (paf.equals("Shamn/ManaTideTotem.jpg"))
    {
      type = 0;
      cost = 3;
      value = 0;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Shamn/RockbiterWeapon.jpg"))
    {
      type = 1;
      cost = 2;
      //Give a monster/player +3 attack this turn
    }
    if (paf.equals("Shamn/SearingTotem.jpg"))
    {
      type = 0;
      cost = 1;
      value = 1;
      currentHP = 1;
      maxHP = 1;
    }
    if (paf.equals("Shamn/SpiritWolf.png"))
    {
      type = 0;
      cost = 2;
      value = 2;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Shamn/StoneclawTotem.png"))
    {
      type = 0;
      cost = 1;
      value = 0;
      currentHP = 2;
      maxHP = 2;
    }
    if (paf.equals("Shamn/Stormcrack.jpg"))
    {
      type = 1;
      cost = 2;
      value = 4;
      //Deal 4 damage to a minion and overload 1
    }
    if (paf.equals("Shamn/StormforgedAxe.jpg"))
    {
      type = 2;
      cost = 2;
      value = 2;
      currentHP = 3;
      maxHP = 3;
    }
    if (paf.equals("Shamn/TotemGolem.jpg"))
    {
      type = 0;
      cost = 2;
      value = 3;
      currentHP = 4;
      maxHP = 4;
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
  
  Player attackPlayer(Player a) {
    a.decHP(value);
    return a;
  }

  String toString() { 
    String result = path.substring(6,path.length()-4);
    if(type ==0){
      result += "\nMonster";
      result += "\nHP: " + currentHP + "/" + maxHP;
    }
    if(type==1){
      result += "\nSpell";
    }
    if(type==2){
      result += "\nWeapon";
      result += "\nHP: " + currentHP + "/" + maxHP;
    }
    
    result += "\nCost: " + cost;
    result += "\nDamage: " + value;
    result += "\n-----------------------";
    return result;
  }
}