class Particle {

  int x; 
  int y; 
  float vx; 
  float vy; 
  int alpha; 
  int red;
  int green; 
  int blue; 
  int size; 
  int velocity;

  public Particle (int x, int y, int red, int green, int blue, int size, int velocity) {
    this.x = x;
    this.y = y;
    this.red  = red; 
    this.blue = blue;
    this.green = green;
    this.size = size/4; 
    this.velocity = velocity;
    vx = random(-velocity, velocity);
    vy = random(-velocity, velocity);
    alpha = 255;
  }

  void update() {
    x += vx;
    y += vy;
    alpha -= 2;
  }

  boolean finished() {
    if (alpha < -20) {
      return true;
    } else {
      return false;
    }
  }

  void show() {
    noStroke();
    //stroke(255);
    fill(red, green, blue, alpha);
    ellipse(x, y, size, size);
  }
}