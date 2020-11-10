

class Wave {

  int xspacing = 6; // How far apart should each horizontal position be spaced
  int w;            // Width of entire wave
  int maxwaves = 8; // total # of waves to add together

  //PVector origin;          // Where does the wave's first point start
  float theta = 0.0;       // Start angle at 0
  float[] amplitude = new float[maxwaves];         // Height of wave
  float period;            // How many pixels before the wave repeats
  float[] dx = new float[maxwaves];      // Value for incrementing X, to be calculated as a function of period and xspacing
  float[] yvalues;         // Using an array to store height values for the wave (not entirely necessary)
  float hoehe;
  

  Wave(float h, float amp, float min, float max) { //PVector o,
    // origin = o.get();
    hoehe = h;
    w = width + 16;
    for (int i = 0; i < maxwaves; i++) {
      amplitude[i] = amp;
      float period = random(min,max);
      dx[i] = (TWO_PI / period) * xspacing;
    }
    yvalues = new float[w/xspacing]; // breite/entfernung zum nächsten Kreis
  }


  void calcWave() {
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.05;

    // Set all height values to zero
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = 0;
    }

    // Accumulate wave height values
    for (int j = 0; j < maxwaves; j++) {
      float x = theta;
      for (int i = 0; i < yvalues.length; i++) {
        // Every other wave is cosine instead of sine
        if (j % 2 == 0) yvalues[i] += sin(x)*amplitude[j];
          else  yvalues[i] += cos(x)*amplitude[j];
        x+=dx[j];
      }
    }
  }

  void display() {
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    for (int x = 0; x < yvalues.length; x++) {
      ellipse(x*xspacing, hoehe+yvalues[x], 2, 2);
    }
  }
}
