import processing.video.*;
import processing.sound.*;

SoundFile recordScratchSound;
Movie movie;

//final float[] timestamps = new float[]{ 0f, 10f, 20f, 30f, 40f, 50f, 60f, 70f, 80f };
final float[] timestamps = new float[]{ 0f, 3.84f, 7.6f, 11.2f, 14.9f, 18.69f, 22.28f, 25.96f };
boolean playSoundEffects = false;

void setup() {
  recordScratchSound = new SoundFile(this, "recordscratch.mp3");
  
  movie = new Movie(this, "balishort.m4v");
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
  switch(key) {
    case 'a':
      jumpToPreviousTimestamp();
    case 'd':
      jumpToNextTimestamp();
      break;
    case ' ':
      toggleSoundEffects();
    default:
      break;
  }
}

void jumpToNextTimestamp() {
  if (nextTimestamp() != -1f) {
    movie.jump(nextTimestamp());
    if (playSoundEffects) { recordScratchSound.play(); }
  }
}

void jumpToPreviousTimestamp() {
  if (previousTimestamp() != -1f) {
    movie.jump(previousTimestamp());
    if (playSoundEffects) { recordScratchSound.play(); }
  }
}

void toggleSoundEffects() {
  playSoundEffects = !playSoundEffects;
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

float previousTimestamp() {
  // Drop some time from current time to make it easier to skip backwards
  float currentTime = movie.time() - 0.2f;
  
  for (int i = timestamps.length - 1; i >= 0; i--) {
    float timestamp = timestamps[i];
    if (currentTime > timestamp) {
      return timestamp; 
    }
  }
  
  return -1f;
}
