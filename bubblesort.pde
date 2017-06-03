int[] numbers=new int[400];
int stackSize, i=0, passes=0, maxVal=400, border=1;
boolean swapped=false;
void setup() {

  size(800, 400, FX2D);
  frameRate(500);
  stackSize=width/numbers.length;
  gen();
  background(0);
  smooth(0);
  noStroke();
}
void draw() {
  background(0);
  drawNumbers(255);
  drawStack(i, color(255, 0, 0));
  drawStack(i+1, color(0, 255, 0));
  if (numbers[i]>numbers[i+1]) {
    numbers[i] = numbers[i] + numbers[i+1];
    numbers[i+1] = numbers[i] - numbers[i+1];
    numbers[i] = numbers[i] - numbers[i+1];
    swapped=true;
  }
  i++;
  if (i==numbers.length-1-passes) {
    i=0;
    if (!swapped) {
      drawNumbers(color(0, 255, 0));
      noLoop();
    }
    passes++;
    swapped=false;
  }
  println("passes", passes, "FPS", frameRate);
}
void gen() {
  for (int i=0; i<numbers.length; i++) {
    numbers[i]=(int)random(0, maxVal);
  }
}
void drawNumbers(color clr) {
  for (int i =0; i<numbers.length; i++) {
    drawStack(i,clr);
  }
}
void drawStack(int i) {
  rect(i*stackSize, height-numbers[i], stackSize-border, numbers[i]);
  fill(255);
}
void drawStack(int i, color clr) {
  fill(clr);
  drawStack(i);
}