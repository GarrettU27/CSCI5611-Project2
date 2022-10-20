String windowTitle = "Swinging Rope";
Camera camera;
Cloth cloth;

int updatesPerFrame = 20;

float ks = 3000;
float kd = 50;
float restLength = 5;

int numPoints = 20;

float obstacleRadius = 30;
Vec3 obstaclePosition = new Vec3(50, 50, 50);
