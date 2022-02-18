void fireBomb(int x, int y, int chosenBallista) {

  if (ballistae[chosenBallista].bombCounter == 0) {
    switch(chosenBallista) {
    case 0:
      if (ballistae[1].bombCounter > 0) {
        chosenBallista = 1;
      } else if (ballistae[2].bombCounter > 0) {
        chosenBallista = 2;
      }
    case 1:
      if (x >= width/2) {
        if (ballistae[2].bombCounter > 0) {
          chosenBallista = 2;
          break;
        } else if (ballistae[0].bombCounter > 0) {
          chosenBallista = 0;
        }
      } else {
        if (ballistae[0].bombCounter > 0) {
          chosenBallista = 0;
        } else if (ballistae[2].bombCounter > 0) {
          chosenBallista = 2;
        }
      }
    case 2:
      if (ballistae[1].bombCounter > 0) {
        chosenBallista = 1;
      } else if (ballistae[0].bombCounter > 0) {
        chosenBallista = 0;
      }
    }
  }

  ballistae[chosenBallista].createBomb((ballistae[chosenBallista].x2 + ballistae[chosenBallista].x3)/2, ballistae[chosenBallista].y1, (float)((x - ballistae[chosenBallista].x1)/130), (float)-y/120, 1);
  bombs[bombsInPlay++] = ballistae[chosenBallista].bomb;
}

void bombMovement() {

  for (int i = 0; i<bombs.length; i++) {
    if (bombs[i] != null && !(bombs[i].status)) {
      PVector position = bombs[i].position;
      bombs[i].integrate(gravityMain);

      if (explosions[i] == 1) {
        fill(250);
        circle(position.x, position.y, 5);
      }
    }
  }
}

void bombSetOffCheck() {

  if (keyPressed == true && key == ' ') {
    for (int i = 0; i < bombs.length; i++) {
      if (bombs[i] != null && (!bombs[i].status)) {
        ///ASK BUDDY
        //bombs[i].status = true;
        bombs[i].active = true;
      }
    }
  }

  for (int i = 0; i < bombs.length; i++) {
    if (bombs[i] != null && bombs[i].active) {
      if (i == 0) {
        if (explosions[i] < 35) {
          explode(i);
        }
      } else if (explosions[i - 1] >= 20 ) {
        explode(i);
      }
    }
  }
}

void explode(int i) {

  if (explosions[i] < 60) {
    noStroke();
    fill(255, 67, 27);
    circle(bombs[i].position.x, bombs[i].position.y, explosions[i]);

    for (int j=0; j<meteors.length; j++) {
      if (meteorState[j] && explosionTouching(j, i)) {
        meteorState[j] = false;
        meteors[j].exploding = true;
        score += (25 * scoreMultiplier());
      }
    }
    
    if(wave > 1 && additionalEnemy.status && explosionTouchingAdditionalEnemy(i)){
        additionalEnemy.status = false;
        additionalEnemy.exploding = true;
        score += (100 * scoreMultiplier());
    }

    explosions[i]+=2;
  } else {
    bombs[i].status = true;
    bombs[i].active = false;
  }
}

boolean explosionTouching(int j, int i) {
  if ((meteors[j].position.x <= bombs[i].position.x + explosions[i]- 10) && (meteors[j].position.x >= bombs[i].position.x - explosions[i] + 10)) {
    if ((meteors[j].position.y <= bombs[i].position.y + explosions[i] - 10) && (meteors[j].position.y >= bombs[i].position.y - explosions[i] + 10)) {
      return true;
    }
  }

  return false;
}
