public class Rope {
  public Vec3 top;
  public Vec3 pos[], vel[], acc[];
  public float restLen;
  
  public Rope(Vec3 top) {
    this.top = top;
    this.pos = new Vec3[numNodes];
    this.vel = new Vec3[numNodes];
    this.acc = new Vec3[numNodes];
    
    float xChange = random(2, 16);
    float yChange = random(2, 16);
    float zChange = random(2, 16);
    
    for (int i = 0; i < numNodes; i++){
      
      pos[i] = new Vec3(0, 0, 0);
      pos[i].x = this.top.x + xChange * i;
      pos[i].y = this.top.y + yChange * i; //Make each node a little lower
      pos[i].z = this.top.z + zChange * i;
      vel[i] = new Vec3(0, 0, 0);
    }
  }
  
  public void updateSelf(float dt) {
    //Reset accelerations each timestep (momentum only applies to velocity)
    for (int i = 0; i < numNodes; i++){
      acc[i] = new Vec3(0, 0, 0);
      acc[i].add(gravity);
    }
    
    //Compute (damped) Hooke's law for each spring
    for (int i = 0; i < numNodes-1; i++){
      Vec3 diff = pos[i+1].minus(pos[i]);
      float stringF = -k*(diff.length() - restLen);
      
      Vec3 stringDir = diff.normalized();
      float projVbot = dot(vel[i], stringDir);
      float projVtop = dot(vel[i+1], stringDir);
      float dampF = -kv*(projVtop - projVbot);
      
      Vec3 force = stringDir.times(stringF+dampF);
      acc[i].add(force.times(-1.0/mass));
      acc[i+1].add(force.times(1.0/mass));
      
      Vec3 friction = vel[i].times(-0.1);
      acc[i].add(friction);
    }
    
    //Eulerian integration
    for (int i = 1; i < numNodes; i++){
      vel[i].add(acc[i].times(dt));
      pos[i].add(vel[i].times(dt));
    }
    
    //Collision detection and response
    for (int i = 0; i < numNodes; i++){
      if (pos[i].y+radius > floor){
        vel[i].y *= -.9;
        pos[i].y = floor - radius;
      }
      
      Vec3 distance = pos[i].minus(obstaclePosition);
      
      if(distance.length() < obstacleRadius + radius) {
        Vec3 direction = distance.normalized();
        vel[i] = direction.times(vel[i].length() * 0.1);
        pos[i] = obstaclePosition.plus(direction.times((obstacleRadius + radius) * 1.01));
      }
    }
  }
  
  public void drawSelf() {
    for (int i = 0; i < numNodes-1; i++){
      pushMatrix();
      line(pos[i].x,pos[i].y,pos[i+1].x,pos[i+1].y);
      translate(pos[i+1].x,pos[i+1].y);
      sphere(radius);
      popMatrix();
    }
  }
}
