// import the library
import com.hamoid.*;

// create a new VideoExport-object
VideoExport videoExport;

// Two wave objects
Wave[] wave = new Wave[10];


void setup() {
  size(700, 700);
  // Initialize a wave with y value, amplitude, and period
  //wave[0] = new Wave(height/2, random(20, 22), 110, 140);
  //wave[1] = new Wave(height/2, random(4, 6), 50, 120);
  
  for (int i = 0; i<wave.length; i++) {
    wave[i] = new Wave((height/wave.length)/2+i*25, random(6, 18), 50, 450); 
  }
  videoExport = new VideoExport(this, "WavesX.mp4");
  videoExport.setFrameRate(30);  
  videoExport.startMovie();
}

void draw() {
  background(0);

  pushMatrix();
  translate(0,height/4);
  for (int i = 0; i<wave.length; i++) {
    wave[i].calcWave();
    wave[i].display();
  }
  popMatrix();
  //Save a frame!
  videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
