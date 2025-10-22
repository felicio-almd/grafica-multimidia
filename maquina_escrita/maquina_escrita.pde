void setup() {
  size(1000, 900);
  background(255);
}

void draw() {
  float radius = 20;
  
  fill(255, 204, 0);
  noStroke();
  rect(150, 300, 700, 200, radius,radius,0,0);  
  
  fill(255, 204, 0);
  stroke(0);
  rect(150, 500, 700, 325,0,0,radius,radius);  

  fill(0 ,0, 0);
  rect(200, 500, 600, 290,0,0,radius,radius); 
  
  fill(255 ,0, 0);
  rect(325, 695, 350, 80, radius,radius,radius,radius); 
}
