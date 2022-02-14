final int menuScreen = 0,
  gameScreen = 1,
  cityReviveCost = 10000;

int screenView = menuScreen,//Used to track the current screen the game is viewing
  score,
  wave,
  enemyCount,//Meteors left in the wave
  bombsInPlay,//Bombs currently in flight
  citiesRevived,
  time,
  explosions[],
  meteorExplosions[];

//State arrays used to store if the objects in the names are alive or dead (true or false)
boolean cityState[],
  ballistaState[],
  meteorState[],
  cityRevived;

City cities[];//Array storing each city

Ballista ballistae[];//Array storing each ballistae

Meteor meteors[];//Array storing the meteors in a wave

Bomb bombs[];

PFont atari;//Font used for the game

PVector gravityMain;

float velocity;

enum state {
  ongoing,
  won,
  lost
}
