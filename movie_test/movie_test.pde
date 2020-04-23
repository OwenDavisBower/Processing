import processing.video.*;

Movie movie;

float[] timestamps = new float[]{ 10f, 20f, 30f, 40f };

void setup() {
  movie = new Movie(this, "bali.m4v");
  movie.frameRate(30);
  movie.play();
  
  // Wait for video to load
  while (movie.width == 0 | movie.height == 0)  delay(10);
  // Set size of surface to movie size (Required for placing movie in background.
  surface.setSize(movie.width, movie.height);
}

void draw() {
  background(movie);
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  if (nextTimestamp() != -1f) {
    movie.jump(nextTimestamp());
  }
}

float nextTimestamp() {
  float currentTime = movie.time();
  
  for (float timestamp : timestamps) {
    if (currentTime < timestamp) {
      return timestamp;
    }
  }
  
  return -1f;
}
