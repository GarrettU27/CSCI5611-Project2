String windowTitle = "Swinging Rope";
Camera camera;
Cloth cloth;

//Simulation Parameters
float floor = 500;
Vec3 gravity = new Vec3(0, 400, 0);
float radius = 5;
float restLen = 10;
float mass = 1.0; //TRY-IT: How does changing mass affect resting length of the rope? Resting length gets much longer
float k = 200; //TRY-IT: How does changing k affect resting length of the rope? Resting length gets shorter
float kv = 30; //TRY-IT: How big can you make kv? Can make it as large as 620 until sim breaks with mass=1 k=200

float ks = 3000;
float kd = 50;
float restLength = 10;

int numPoints = 10;

float obstacleRadius = 30;
Vec3 obstaclePosition = new Vec3(50, 50, 50);
