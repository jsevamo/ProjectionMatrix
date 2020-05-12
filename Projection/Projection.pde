float angle = 0;

PVector [] points = new PVector[8];



void setup()
{
  size(600,400);
 
  points[0] = new PVector(-0.5,-0.5, -0.5);
  points[1] = new PVector(0.5,-0.5, -0.5);
  points[2] = new PVector(0.5,0.5, -0.5);
  points[3] = new PVector(-0.5,0.5, -0.5);
  points[4] = new PVector(-0.5,-0.5, 0.5);
  points[5] = new PVector(0.5,-0.5, 0.5);
  points[6] = new PVector(0.5,0.5, 0.5);
  points[7] = new PVector(-0.5,0.5, 0.5);
  
}

void draw()
{
  background(0);
  translate(width/2, height/2);
  stroke(255);
  strokeWeight(10);
  noFill();
  
  float [][] rotationZ = {
  {cos(angle),-sin(angle), 0},
  {sin(angle),cos(angle), 0},
  {0           ,0,        1}
  };
  
  float [][] rotationX = {
  {1,0, 0},
  {0,cos(angle), -sin(angle)},
  {0,sin(angle), cos(angle)}
  };
  
  float [][] rotationY = {
  {cos(angle),0, -sin(angle)},
  {0,1, 0},
  {sin(angle),0, cos(angle)}
  };
  
  PVector[] projected = new PVector[8];
  
  int index = 0;
  for(PVector v : points)
  {
    
    
    float[][] rotatedM= matmul(rotationY, v);
    rotatedM = matmul(rotationX, rotatedM);
    rotatedM = matmul(rotationZ, rotatedM);
    
    PVector rotated = matrixToVec(rotatedM);
    
    float distance = 2;
    float z = 1 / (distance - rotated.z);
    
    
    // Orthogonal Projection just with ones
    float [][] projection = {
    {z,0,0},
    {0,z,0}
    };
    
    
    float [][] projected2dM = matmul(projection, matrixToVec(rotatedM));
    PVector projected2d = matrixToVec(projected2dM);
    projected2d.mult(200);
    projected[index] = projected2d;
    point(projected2d.x, projected2d.y);
    index++;
  }
  
  //connect(0,1, projected);
  //connect(1,2, projected);
  //connect(2,3, projected);
  //connect(3,0, projected);
  
  //connect(4,5, projected);
  //connect(5,6, projected);
  //connect(6,7, projected);
  //connect(7,4, projected);
  
  //connect(0,4, projected);
  //connect(1,5, projected);
  //connect(2,6, projected);
  //connect(3,7, projected);
  
  for(int i = 0; i < 4 ; i++)
  {
    connect(i, (i+1) % 4, projected);
    connect(i+4, ((i+1) % 4)+4, projected);
    connect(i, i+4, projected);
  }
  
  angle += 0.02;
  
}

void connect(int i, int j, PVector[] points)
{
  PVector a = points[i];
  PVector b = points[j];
  strokeWeight(1);
  stroke(255);
  line(a.x, a.y, b.x, b.y);
}
