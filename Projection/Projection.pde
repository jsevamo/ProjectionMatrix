float angle = 0;

PVector [] points = new PVector[8];

float [][] projection = {
{1,0,0},
{0,1,0}
};

void setup()
{
  size(600,400);
 
  points[0] = new PVector(-50,-50, -50);
  points[1] = new PVector(50,-50, -50);
  points[2] = new PVector(50,50, -50);
  points[3] = new PVector(-50,50, -50);
  points[4] = new PVector(-50,-50, 50);
  points[5] = new PVector(50,-50, 50);
  points[6] = new PVector(50,50, 50);
  points[7] = new PVector(-50,50, 50);
  
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

  
  for(PVector v : points)
  {
    
    
    float[][] rotatedM= matmul(rotationY, v);
    rotatedM = matmul(rotationX, rotatedM);
    rotatedM = matmul(rotationZ, rotatedM);
    float [][] projected2dM = matmul(projection, matrixToVec(rotatedM));
    PVector projected2d = matrixToVec(projected2dM);
    
    point(projected2d.x, projected2d.y);
    
  }
  
  angle += 0.03;
  
}
