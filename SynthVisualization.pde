import processing.sound.*;

float randW, randS;

int cont = 300;
int cont1 = 299;

int type = 1;

FFT fft;
AudioIn in;
int bands = 4;
float[] spectrum = new float[bands];
color[] colors = new color[bands];
float[] randA = new float[bands];
float[] randB = new float[bands];

void setup() {
  size(1280, 720);
  background(100);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
  
  colors[0] = color(222,111,237);
  colors[1] = color(189,236,56);
  colors[2] = color(111,237,224);
  colors[3] = color(5,255,161);
}

void mousePressed() {
  if(type == 0) {
    type = 1;
    randA[0] = random(0,1)*40+5;
  } 
  else {
    type = 0;
    randA[0] = random(0,1)*40+5;
  }
}

void draw() {

  fft.analyze(spectrum);
  
  if(cont > cont1){
    
    for(int i = 0; i < bands; i++){
      randA[i] = random(60);
      randB[i] = random(1000,500);
    }
    
    randW = random(0.003, 0);
    randS = random(0.002, 0.05);
    
    cont = 0;
    cont1 = floor(random(299, 599));
    
  } else{
    cont++;  
  }

  blendMode(BLEND);
  background(0);
  blendMode(SCREEN);
  noFill();

  for(int i = 0; i < bands; i++){
    syneCreator(colors[i], randA[i], randB[i], spectrum[i]);
  }
}

void syneCreator(color col, float randA, float randB, float bandLevel){
  beginShape();
  for(int w = -20; w < width + 20; w += 5){
    strokeWeight(100*bandLevel+5);
    float h = ((randA*bandLevel)+50)*sin(w/(randB)) * pow(abs(sin(w * randW + frameCount * randS)), 5) + height/2;
    curveVertex(w,h);
    stroke(col);
  }
  endShape();
}
