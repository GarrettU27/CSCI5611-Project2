public class Cloth {  
  public Vec3[][] positions;
  public Vec3[][] vels;
  
  public Cloth() {
    this.positions = new Vec3[numPoints][numPoints];
    this.vels = new Vec3[numPoints][numPoints];
    
    this.setInitialValues();
  }
  
  public void setInitialValues() {
    println("Setting!");
    Vec3 zero = new Vec3(0, 0, 0);
    
    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        Vec3 pos = new Vec3(10*i, 0, 10*j);
        this.positions[i][j] = pos;
        this.vels[i][j] = zero;
      }
    }
  }
  
  public void drawSelf() {
    beginShape(TRIANGLES);
    
    Vec3 pos;
    
    for (int i = 0; i < numPoints - 1; i++) {
     for (int j = 0; j < numPoints - 1; j++) {
       fill(100, 149, 237);
       
       if (j % 2 == 0) {
         pos = this.positions[i][j];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i + 1][j];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i][j + 1];
         vertex(pos.x, pos.y, pos.z); 
         
         fill(143, 188, 143);
         
         pos = this.positions[i + 1][j];
         vertex(pos.x, pos.y, pos.z);
         
         pos = this.positions[i][j + 1];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i + 1][j + 1];
         vertex(pos.x, pos.y, pos.z);
       } else {
         pos = this.positions[i][j];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i + 1][j];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i + 1][j + 1];
         vertex(pos.x, pos.y, pos.z);
         
         fill(143, 188, 143);
         
         pos = this.positions[i + 1][j + 1];
         vertex(pos.x, pos.y, pos.z); 
         
         pos = this.positions[i][j];
         vertex(pos.x, pos.y, pos.z);
         
         pos = this.positions[i][j + 1];
         vertex(pos.x, pos.y, pos.z); 
       }
     }
    }
    
    endShape();
  }
  
  private void updateForceBetween(int ai, int aj, int bi, int bj, Vec3[][] newVels, float dt) {
    Vec3 aPos = this.positions[ai][aj];
    Vec3 bPos = this.positions[bi][bj];
    
    Vec3 aVel = this.vels[ai][aj];
    Vec3 bVel = this.vels[bi][bj];
    
    Vec3 e = bPos.minus(aPos);
    float l = e.length();
    e.normalize();
    float v1 = dot(e, aVel);
    float v2 = dot(e, bVel);
    float f = -ks * (restLength - l) - kd * (v1 - v2);
    
    newVels[ai][aj] = aVel.plus(e.times(f * dt));
    newVels[bi][bj] = bVel.minus(e.times(f * dt));
  }
  
  public void updateSelf(float dt) {
    Vec3[][] newVels = this.vels.clone();
    
    // update forces in x direction
    for (int i = 0; i < numPoints - 1; i++) {
      for (int j = 0; j < numPoints; j++) {
        updateForceBetween(i, j, i + 1, j, newVels, dt);
      }
    }
    
    // update forces in y direction
    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints - 1; j++) {
        updateForceBetween(i, j, i, j + 1, newVels, dt);
      }
    }
    
    // add gravity to points
    Vec3 gravity = new Vec3(0, 0.1, 0);
    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        newVels[i][j].add(gravity);
      }
    }
    
    // fix top row in place
    for(int i = 0; i < numPoints; i++) {
      newVels[0][i] = new Vec3(0, 0, 0);
    }
    
    // set new velocities to old velocities
    // update positions
    this.vels = newVels;
    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        this.positions[i][j].add(this.vels[i][j].times(dt));
      }
    }
    
    // calculate if cloth is colliding with obstacle
    for (int i = 0; i < numPoints; i++) {
      for (int j = 0; j < numPoints; j++) {
        float d = obstaclePosition.distanceTo(this.positions[i][j]);
        
        if (d < obstacleRadius + 1.1) {
          Vec3 normal = obstaclePosition.minus(this.positions[i][j]);
          normal.normalize();
          Vec3 bounce = normal.times(dot(normal, this.vels[i][j]));
          this.vels[i][j].subtract(bounce.times(1.1));
          this.positions[i][j].add(normal.times(0.1 + obstacleRadius - d));
        }
      }
    }
  }
}