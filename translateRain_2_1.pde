import processing.video.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import ddf.minim.*;
//import codeanticode.syphon.*;


Kinect kinect;
//SyphonServer server;
Minim minim;
AudioPlayer player;

PImage thresholdImage;
Table sampleText;
int rowCount;
int offsetY = -11000;
//int offsetY = -100;
PImage videoImage;
PGraphics shadow;
PFont font;
int wordNum;

Word[] words;

void setup() {
  size(640, 480);
  //pixelDensity(displayDensity());    //描画を滑らかに
  kinect = new Kinect(this);
  //server = new SyphonServer(this, "Processing Syphon");
  kinect.initDepth();
  thresholdImage = new PImage(kinect.width, kinect.height, ARGB);
  shadow = createGraphics(kinect.width, kinect.height);
  sampleText = loadTable("CSV/hg_jp4.csv");
  rowCount = sampleText.getRowCount();                           //rowCount = 368  

  minim = new Minim(this);

  //背景
  //bg = loadImage("Image/kounai_sample.jpg");
  //bg.filter(BLUR, 20);                                                //背景のぼかし

  //wordNum = 200;
  wordNum = 200;
  words = new Word[rowCount];

  for (int i = 0; i < wordNum; i++) {
    int random = int(random(rowCount));
    //String hg = sampleText.getString(i, 0);
    String hg = sampleText.getString(random, 0);
    //String jp = sampleText.getString(i, 1);
    String jp = sampleText.getString(random, 1);
    player = minim.loadFile(hg + ".mp3");
    println(i + " , " + hg);

    words[i] = new Word(jp, hg, random(width), random(offsetY, 0), player);
    //words[i] = new Word(jp, hg, random(width), random(offsetY, 0));
  }

  font = createFont("Osaka", 30);
  textFont(font);
  textAlign(CENTER);
}

void draw() {
  PImage depthImege = flipImage(kinect.getDepthImage());
  float threshold = map(mouseX, 0, width, 0, 255);
  //float threshold = 133.0;
  println(threshold);
  
  updateThresholdImage(depthImege, threshold);

  noStroke();

  background(255);

  shadow.beginDraw();
  shadow.background(0, 0, 0, 0);
  shadow.endDraw();

  for (int i = 0; i < wordNum; i++) {
    Word word = words[i];                                                  //スコープ内で一時的に使うwordに入れる
    word.isJp = isHit(depthImege, threshold, int(word.x), int(word.y));
    word.update();
    word.draw();
  }

  shadow.beginDraw();
  shadow.mask(thresholdImage);
  shadow.endDraw();

  image(shadow, 0, 0);

  //server.sendScreen();
}