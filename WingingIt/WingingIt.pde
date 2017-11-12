Airplane test; 
String menu = "main";

ArrayList<EnemyPlane> enemyPlanes = new ArrayList<EnemyPlane>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

int frameSinceLastNewEnemy = 0;
int ePlaneDelay = 5;
int planeDelayDecrement = 0;

int framesSinceLastPowerup =300;
int powerupDelay = 800;

float score = 0;

void setup() {
  size(1000, 1000);
  background(255);
  test = new Airplane(500, 500);
}


void draw() {
  switch(menu) {
  case "main":
    mainMenu();
    break;
  case "game":
    gameMenu();
    break;
  case "rule":
    rulesMenu();
    break;
  case "over":
    overMenu();
    break;
  }
}


void mainMenu() {
  background(#bad9ff);
  noStroke();

  fill(255);
  ellipse(100, 100, 175, 75);
  ellipse(120, 130, 175, 75);
  ellipse(150, 50, 175, 75);
  ellipse(180, 90, 175, 75);

  textFont(createFont("Tahoma", 144));
  text("Winging It", 500, 300);

  Button playButton = new Button(500, 750, 150, 80, "Start");
  if (playButton.isClicked()) {
    menu = "game";
  }
  playButton.show();

  Button rulesButton = new Button(500, 850, 150, 80, "Rules");
  if (rulesButton.isClicked()) {
    menu = "rule";
  }
  rulesButton.show();
}

void gameMenu() {
  background(#bad9ff);

  //----------------BUTTONS---------------
  //exit button
  Button exitButton = new Button(25, 25, 25, 25, "X");
  exitButton.show();
  if (exitButton.isClicked()) {
    menu = "main"; 
    resetGame();
  }


  //-----------------ENEMIES----------------------
  //crate new planes
  if (frameSinceLastNewEnemy >= ePlaneDelay) {
    int rX;
    int rY;
    if (random(0, 1)<.5) {
      rX = (int)random(-100, -50);
    } else {
      rX = (int)random(1050, 1100);
    }
    if (random(0, 1)<.5) {
      rY = (int)random(-100, -50);
    } else {
      rY = (int)random(1050, 1100);
    }
    enemyPlanes.add(new EnemyPlane(rX, rY));
    frameSinceLastNewEnemy = 0;
  }
  if (planeDelayDecrement >=1500 && ePlaneDelay !=1) {
    ePlaneDelay--; 
    planeDelayDecrement = 0;
  }
  planeDelayDecrement++;

  //show planes
  for (int i = 0; i<enemyPlanes.size(); i++) {
    enemyPlanes.get(i).show();
  }

  //get rid of out-of-bount planes
  for (int i = enemyPlanes.size()-1; i>=0; i--) {
    if (enemyPlanes.get(i).x>1150 || enemyPlanes.get(i).x<-150) {
      enemyPlanes.remove(i);
    } else if (enemyPlanes.get(i).y>1150 || enemyPlanes.get(i).y<-150) {
      enemyPlanes.remove(i);
    }
  }

  //check if enemy was hit
  for (int i = enemyPlanes.size()-1; i>=0; i--) {
    for (int j = test.bullets.size()-1; j>=0; j--) {
      try {
        if (dist(test.bullets.get(j).point.getX(), test.bullets.get(j).point.getY(), enemyPlanes.get(i).x, enemyPlanes.get(i).y) < 50) {
          enemyPlanes.remove(i);
          test.bullets.remove(j);
          score+=5;
        }
      }
      catch(Exception e) {
      };
    }
  }

  //check if we were hit
  for (int i = enemyPlanes.size()-1; i>=0; i--) {
    try {
      if (dist(test.x, test.y, enemyPlanes.get(i).x, enemyPlanes.get(i).y) < 100) {
        if (test.isShielded()) {
          test.breakShield();
          enemyPlanes.remove(i);
        } else {
          enemyPlanes.remove(i);
          menu = "over";
        }
      }
    }
    catch(Exception e) {
    };
  }
  textFont(createFont("Tahoma", 72));
  fill(255);
  text("Score: " + (int)score, 500, 100);
  score+=(6-ePlaneDelay)/60.0f;

  frameSinceLastNewEnemy++;




  //-------POWERUPS----------------------------
  if (framesSinceLastPowerup > powerupDelay) {
    int rand = (int)random(0, 4);
    switch(rand) {
    case 0:
      powerUps.add(new Shield(random(0, width), random(0, height)));
      break;
    case 1:
      powerUps.add(new BulletSpeedUp(random(0, width), random(0, height)));
      break;
    case 2:
      powerUps.add(new BulletRateUp(random(0, width), random(0, height)));
      break;
    case 3:
      powerUps.add(new SpeedUp(random(0,width),random(0,height)));
      break;
    }
    framesSinceLastPowerup = 0;
  }

  //check if we got powerUp
  for (int i = powerUps.size()-1; i>=0; i--) {
    try {
      if (dist(test.x, test.y, powerUps.get(i).x, powerUps.get(i).y) < 100) {
        String type = powerUps.get(i).getType();
        switch(type) {
        case "shield":
          test.giveShield();
          break;
        case "bsu":
          test.increaseBulletSpeed(5);
          break;
        case "bru":
          test.increaseBulletRate(1.6667);
          break;
        case "su":
          test.increaseSpeed(2);
          break;
        }
        powerUps.remove(i);
      }
    }
    catch(Exception e) {
    };
  }


  for (int i = 0; i<powerUps.size(); i++) {
    powerUps.get(i).show();
  }
  framesSinceLastPowerup++;

  test.show();
}

void resetGame() {
  test = new Airplane(500, 500);
  enemyPlanes.clear();
  powerUps.clear();
  frameSinceLastNewEnemy = 0;
  ePlaneDelay = 5;
  planeDelayDecrement = 0;
  framesSinceLastPowerup = 0;
  powerupDelay = 1200;
  score=0;
}

void rulesMenu() {
  background(#bad9ff);

  Button exitButton = new Button(50, 50, 50, 50, "X");
  exitButton.show();
  if (exitButton.isClicked()) {
    menu = "main"; 
    resetGame();
  }

  fill(255);

  textFont(createFont("Tahoma", 60));
  text("Rules:", 500, 200);

  textFont(createFont("Tahoma", 32));
  text("-Click to move the plane towards the mouse", 500, 300);
  text("-Use the space bar to shoot", 500, 375);
  text("Power Ups:", 500, 450);


  noStroke();
  fill(#d3f9b6);
  ellipse(300, 525, 40, 40); 
  rectMode(CENTER);
  fill(#406326);
  rect(300, 525, 20, 6);
  rect(300, 525, 6, 20);
  text("Shield", 480, 545);

  fill(#ffd6a5);
  ellipse(300, 625, 40, 40); 
  rectMode(CENTER);
  fill(#c48e4c);
  rect(300-6, 625-4, 4, 4);
  rect(300, 625+4, 4, 4);
  rect(300+6, 625-4, 4, 4);
  text("Bullet Rate Up", 535, 645);

  fill(#f9f1b6);
  ellipse(300, 725, 40, 40); 
  rectMode(CENTER);
  fill(#c4b64c);
  rect(300-6, 725, 4, 4);
  rect(300, 725, 4, 4);
  rect(300+6, 725, 4, 4);
  text("Bullet Speed Up", 550, 745);
  fill(255);
  text("... plus more.", 500, 845);
}

void overMenu() {
  background(#bad9ff);
  
  fill(255);
  textFont(createFont("Tahoma", 60));
  text("You scored " + (int)score + " points!",500,300);
  Button replayButton = new Button(500, 750, 150, 80, "Replay");
  if (replayButton.isClicked()) {
    resetGame();
    menu="game";
  }
  replayButton.show();

  Button exitButton = new Button(500, 850, 400, 80, "Return to Main Menu");
  if (exitButton.isClicked()) {
    resetGame();
    menu="main";
  }
  exitButton.show();
}

void keyPressed(){
 if(key=='r'){
  save("img.png"); 
 }
}