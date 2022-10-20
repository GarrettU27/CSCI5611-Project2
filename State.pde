String windowTitle = "Swinging Rope";
Camera camera;
Cloth cloth;

float ks = 3000;
float kd = 50;
float restLength = 10;

int numPoints = 10;

float obstacleRadius = restLength * 3;
Vec3 obstaclePosition = new Vec3(restLength * 5, restLength * 5, restLength * 5);
