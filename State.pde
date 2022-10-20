String windowTitle = "Swinging Rope";
Camera camera;

//Simulation Parameters
float floor = 500;
Vec3 gravity = new Vec3(0, 400, 0);
float radius = 5;
float restLen = 10;
float mass = 1.0; //TRY-IT: How does changing mass affect resting length of the rope? Resting length gets much longer
float k = 200; //TRY-IT: How does changing k affect resting length of the rope? Resting length gets shorter
float kv = 30; //TRY-IT: How big can you make kv? Can make it as large as 620 until sim breaks with mass=1 k=200

int numNodes = 10;
int numRopes = 5;
Rope ropes[] = new Rope[numRopes];

float obstacleRadius = 20;
Vec3 obstaclePosition = new Vec3(200, 150, 0);
