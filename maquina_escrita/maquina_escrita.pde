void setup() {
  size(1000, 1000);
  background(255);
}

void draw() {
  float radius = 20;
  
  fill(255, 204, 0);
  noStroke();
  rect(150, 150, 300, 100, radius,radius,0,0);  
  
  fill(255, 204, 0);
  stroke(0);
  rect(100, 239, 401, 100);  

  fill(0 ,0, 0);
  rect(125, 239, 350, 50);  
}
