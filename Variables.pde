final int menuScreen = 0,
  gameScreen = 1,
  cityReviveCost = 10000;

int screenView = menuScreen,//Used to track the current screen the game is viewing
  score,
  wave,
  enemyCount,//Meteors left in the wave
  bombsInPlay,//Bombs currently in flight
  citiesRevived, //Number of cities revived in a game
  time,//Time at which a city is revived at
  explosions[],//Size of explosions for each bomb
  meteorExplosions[];

//State arrays used to store if the objects in the names are alive or dead (true or false)
boolean cityState[],
  ballistaState[],
  meteorState[],
  cityRevived;

City cities[];//Array storing each city

Ballista ballistae[];//Array storing each ballistae

Meteor meteors[];//Array storing the meteors in a wave

Bomb bombs[];//Array storing the bombs for a wave

PFont atari;//Font used for the game

PVector gravityMain;//Constant for the impact of gravity

float terminalVelocity;//Max Y velocity that metoers can reach in a given round

enum state {//Three possible states for a wave
  ongoing,
  won,
  lost
}

AdditionalEnemy additionalEnemy;//Instance of the bomber or satellite

import ddf.minim.*;

Minim minim;
AudioPlayer bombFired;
AudioPlayer meteorExploded;
AudioPlayer additionalEnemyExploded;
AudioPlayer bombExploded;
AudioPlayer gameStart;
AudioPlayer gameOver;
