public class Point {
  public Vec3 pos;
  public Vec3 vel;
  
  public Point(Vec3 pos, Vec3 vel) {
    this.pos = pos;
    this.vel = vel;
  }
}

void updateForceBetween(Point a, Point b, float dt) {
  Vec3 e = b.pos.minus(a.pos);
  float l = e.length();
  e.normalize();
  float v1 = dot(e, a.vel);
  float v2 = dot(e, b.vel);
  float f = -ks * (restLength - l) - kd * (v1 - v2);
  a.vel.add(e.times(f * dt));
  b.vel.subtract(e.times(f * dt));
}
