//Create Window
void setup() {
  size(600, 600, P3D);
  camera = new Camera();
  setInitialCameraPosition();
  surface.setTitle(windowTitle);
  cloth = new Cloth();
}

void setInitialCameraPosition() {
  camera.position.x = 114.92473;
  camera.position.y = -78.1319;
  camera.position.z = 197.25558;
  
  camera.phi = -0.57670313;
  camera.theta = -5.785404;
}

void update(float dt){
  cloth.updateSelf(dt);
}

//Draw the scene: one sphere per mass, one line connecting each pair
boolean paused = true;
void draw() {
  background(255);
  lights();
  noStroke();
  
  camera.Update(1.0/frameRate);
  
  if (!paused) {
    for(int i = 0; i < 40; i++) {
      update(1/(40*frameRate));
    }
  }
  fill(255, 0, 0);
  
  pushMatrix();
  translate(obstaclePosition.x, obstaclePosition.y, obstaclePosition.z);
  sphere(obstacleRadius);
  popMatrix();
  
  cloth.drawSelf();
  
  if (paused)
    surface.setTitle(windowTitle + " [PAUSED]");
  else
    surface.setTitle(windowTitle + " "+ nf(frameRate,0,2) + "FPS");
}

void keyPressed(){
  camera.HandleKeyPressed();
  
  if (key == ' ')
    paused = !paused;
    
  if (key == 'r') { 
    cloth.setInitialValues();
    setInitialCameraPosition();
  }
}

void keyReleased()
{
  camera.HandleKeyReleased();
}
