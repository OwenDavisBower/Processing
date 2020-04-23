float scale = 1;

void setup() {
  size(600, 600);  // size always goes first!
  surface.setResizable(true);
}

void draw() {
  background(50);
  noStroke();
  
  float tanWave = tan(radians(frameCount));
  float sinWave = sin(radians(frameCount));
  
  fill(200,200,200);
  if (keyPressed) {
    scale += 1;
  } else {
    if (scale > 1) {
      scale -= 1;
    }
  }
  float radius = scale * 50 + sinWave * 20;
  ellipse(width / 2, height / 2, radius, radius);
  fill(255);
  
  ellipse(width / 2, height / 2 + sinWave * 200, 200, 200 - 200 * tanWave);
  fill(230,230,230);
  ellipse(width / 2 + sinWave * 200, height / 2, 100 - 100 * tanWave, 100);
  
  
}
