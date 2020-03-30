import processing.sound.*;

int cont = 300;
int cont1 = 299;

int type = 1;

FFT fft;
AudioIn in;
int bands = 4;
float[] spectrum = new float[bands];

void setup() {
  size(1280, 720);
  background(100);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  fft.input(in);
}

void mousePressed() {
  if(type == 0) {
    type = 1;
    rand = random(0,1)*40+5;
  } 
  else {
    type = 0;
    rand = random(0,1)*40+5;
  }
}
float rand, rand2, rand3, rand4, rand5, rand6, randW, randS;
void draw() {
//------random clock-------

  fft.analyze(spectrum);
  if(cont > cont1){
    rand = random(60);
    rand2 = random(60);
    rand3 = random(60);
    rand4 = random(1000,500);
    rand5 = random(1000,500);
    rand6 = random(1000,500);
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
  
//-------red Line -------
  beginShape();
  for(int w = -20; w < width + 20; w += 5){
    float micLevel = spectrum[0];
    strokeWeight(100*micLevel+5);
    float h = ((rand4*micLevel)+50)*sin(w/(rand)) * pow(abs(sin(w * randW + frameCount * randS)), 5) + height/2;
    curveVertex(w,h);
    stroke(222,111,237);
  }
  endShape();
  
//----blue line---------
  beginShape();
  for(int w = -20; w < width + 20; w += 5){
    float micLevel = spectrum[1];
    strokeWeight(100*micLevel+10);
    float h = (rand5*micLevel+60)*sin(w/(rand2)) * pow(abs(sin(w * randW + frameCount * randS)), 5) + height/2;
    curveVertex(w,h);
    stroke(189,236,56);
  }
  endShape();
//-----green line-------
  beginShape();
  for(int w = -20; w < width + 20; w += 5){
    float micLevel = spectrum[2];
    strokeWeight(100*micLevel+5);
    float h = (rand6*micLevel+50)*sin(w/(rand3)) * pow(abs(sin(w * randW + frameCount * randS)), 5) + height/2;
    curveVertex(w,h);
    stroke(111,237,224);
  }
  endShape();

}
