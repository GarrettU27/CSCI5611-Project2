//Create Window
void setup() {
  size(600, 600, P3D);
  camera = new Camera();
  surface.setTitle(windowTitle);
  initScene();
}

void initScene(){
  Vec2 firstTop = new Vec2(140,50);
  for (int i = 0; i < numRopes; i++) {
    firstTop.x = firstTop.x + 20;
    ropes[i] = new Rope(firstTop);
  }
}

void update(float dt){
  for (int i = 0; i < numRopes; i++) {
    ropes[i].updateSelf(dt);
  }
}

//Draw the scene: one sphere per mass, one line connecting each pair
boolean paused = true;
void draw() {
  background(255);
  noLights();

  camera.Update(1.0/frameRate);
  
  if (!paused) {
    for(int i = 0; i < 20; i++) {
      update(1/(20*frameRate));
    }
  }
  fill(255, 0, 0);
  circle(obstaclePosition.x, obstaclePosition.y, obstacleRadius * 2);
  
  fill(0,0,0);
  
  for (int i = 0; i < numRopes; i++) {
    ropes[i].drawSelf();
  }
  
  fill( 0, 0, 255 );
  pushMatrix();
  translate( 0, 0, -50 );
  box( 20 );
  popMatrix();
  
  pushMatrix();
  translate( 0, 0, 50 );
  box( 20 );
  popMatrix();
  
  fill( 255, 0, 0 );
  pushMatrix();
  translate( -50, 0, 0 );
  box( 20 );
  popMatrix();
  
  pushMatrix();
  translate( 50, 0, 0 );
  box( 20 );
  popMatrix();
  
  fill( 0, 255, 0 );
  pushMatrix();
  translate( 0, 50, 0 );
  box( 20 );
  popMatrix();
  
  pushMatrix();
  translate( 0, -50, 0 );
  box( 20 );
  popMatrix();
  
  if (paused)
    surface.setTitle(windowTitle + " [PAUSED]");
  else
    surface.setTitle(windowTitle + " "+ nf(frameRate,0,2) + "FPS");
}

void keyPressed(){
  camera.HandleKeyPressed();
  
  if (key == ' ')
    paused = !paused;
}

void keyReleased()
{
  camera.HandleKeyReleased();
}
