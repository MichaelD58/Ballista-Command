/**
  * Calls the createBomb function for the chosen ballista before adding the bomb to the overall bomb array
  * and incrementing the counter for bombs used in a round
  *
  * @param x a float of the x coordinate of the crosshair - where the bomb should be flying to
  * @param y a float of the y coordinate of the crosshair - where the bomb should be flying to
  * @param chosenBallista the index in the ballistae array indicating which ballista is firing this bomb
  */
void fireBomb(int x, int y, int chosenBallista) {
  ballistae[chosenBallista].createBomb((ballistae[chosenBallista].x2 + ballistae[chosenBallista].x3)/2, ballistae[chosenBallista].y1, (float)((x - ballistae[chosenBallista].x1)/130), (float)-y/120, 1);
  bombs[bombsInPlay++] = ballistae[chosenBallista].bomb;
  //Bomb fired sound
  bombFired.play();
  bombFired.rewind();
}

/**
  * Draws the bombs in play if they have not been exploded yet. Also calls the bomb's integrate method,
  * updating the bomb's vectors
  */
void bombMovement() {
  for (int i = 0; i<bombs.length; i++) {
    if (bombs[i] != null && !(bombs[i].status)) {//If the bomb has been initialised and has not been set off
      PVector position = bombs[i].position;
      bombs[i].integrate(gravityMain);//Method call to update bomb vectors
      //Draws representation of bomb if explosion value is at default (not exploded)
      if (explosions[i] == 1) {
        fill(250);
        circle(position.x, position.y, 5);
      }
    }
  }
}

/**
* Checks to see if the player has pressed the key to detonate the currently deployed bombs.
* Also manages the delayed explosions of the bombs that have already been activated.
*/
void bombSetOffCheck() {
  //Method to activate new bombs
  if (keyPressed == true && key == ' ') {//Key to detonate in play bombs
    for (int i = 0; i < bombs.length; i++) {
      if (bombs[i] != null && (!bombs[i].status)) {//If bomb is initialised and not done with
          bombs[i].active = true;//Bomb is activated
          bombExploded.play();
          bombExploded.rewind();
      }
    }
  }

  //Method to manage activated bombs
  for(int i = 0; i < bombs.length; i++) {
    if(bombs[i] != null && bombs[i].active) {//If bomb is initialised and activated
      if(i == 0) {//First bomb in the bomb array
          bombs[i].status = true;//Bomb is now used
          explode(i);//Explode function is called to show visual explosion and manage collisions
        //Rest of the bombs in the array
      }else if(explosions[i - 1] >= 20 ){
        bombs[i].status = true;//Bomb is now used
        explode(i);//Explode function is called to show visual explosion and manage collisions      
      }
    }
  }
}

/**
  * Check to see if a bomb is still to explode, continuing to draw the growing explosion if so. There is also a series of checks
  * to see if the bomb's explosion is colliding with both meteors and the additional enemies. If collisions are detected, then
  * the thing being collided with is set to explode and the score is increased accordingly
  *
  * @param i an integer for the index of the bomb which explosion is being dealt with
  */
void explode(int i) {
  //If bomb has not fully exploded
  if (explosions[i] < 60) {
    noStroke();
    fill(255, 67, 27);
    circle(bombs[i].position.x, bombs[i].position.y, explosions[i]);//Explosion is drawn

    //Check with every meteor to see if it is colliding with the bomb's explosion 
    for (int j=0; j<meteors.length; j++) {
      if (meteorState[j] && explosionTouching(j, i)) {
        meteorState[j] = false;//Meteor state set to false as it has been exploded
        meteors[j].exploding = true;//Meteor explosion state activated
        score += (25 * scoreMultiplier());
        //Meteor explosion sound
        meteorExploded.play();
        meteorExploded.rewind();
      }
    }
    
    //Check with the additional enemy to see if it is colliding with the bomb's explosion 
    if(wave > 1 && additionalEnemy.status && bombExplosionTouchingAdditionalEnemy(i)){
        additionalEnemy.status = false;//Additional enemy state set to false as it has been exploded
        additionalEnemy.exploding = true;//Additional enemy explosion state activated
        score += (100 * scoreMultiplier());
        //Addiional enemy explosion sound
        additionalEnemyExploded.play();
        additionalEnemyExploded.rewind();
    }

    explosions[i]+=2;
  } else {
    bombs[i].active = false;//Explosion is finished and explosion state is ended
  }
}

/**
  * Check to see if a meteor is within the bomb's explosion
  *
  * @param i an integer for the index of the meteor being checked
  * @param j an integer for the index of the bomb which explosion is being checked against the meteor for a collision
  * @return Boolean that represents whether there is a collision occuring
  */
boolean explosionTouching(int j, int i) {
  if ((meteors[j].position.x <= bombs[i].position.x + explosions[i]- 20) && (meteors[j].position.x >= bombs[i].position.x - explosions[i] + 20)) {
    if ((meteors[j].position.y <= bombs[i].position.y + explosions[i] - 20) && (meteors[j].position.y >= bombs[i].position.y - explosions[i] + 20)) {
      return true;
    }
  }

  return false;
}
