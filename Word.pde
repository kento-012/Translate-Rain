class Word {
  String jp;
  String hg;
  boolean isJp;
  float x, y;
  float speed, v0, gravity, friction;
  float size;
  int maxJp;
  int maxHg;
  float angle;
  boolean initFlag;

  float s;

  AudioPlayer player;




  Word(String _jp, String _hg, float _x, float _y, AudioPlayer _player) {
    //Word(String _jp, String _hg, float _x, float _y) {
    jp = _jp;
    hg = _hg;
    isJp = true;
    x = _x;
    y = _y;
    player = _player;
    gravity = 0.05;
    friction = 0.1;
    v0 = random(1.0, 3.0);
    s = random(15.0, 60.0);
    size = s;

    angle = 0.0;

    initFlag = false;
  }

  void update() {
    textSize(size);

    if (y > 0) {
      //gravity = 0.05;
      gravity = 0.03;
      speed += (v0 + gravity);
      y += speed;
      v0 = 0;
    } else {
      y += v0;
    }

    if (!initFlag) {
      if (isJp) {
        size *= 1.5;
        player.rewind();
        player.play();
        initFlag = true;
      }
    }

    if (isJp) {
      speed *= (1.0 - friction);
      if (speed < 3.0) {
        speed = 3.0;
      }
    }


    if (y > height+100) {
      x = random(width);
      y = random(offsetY, 0);
      v0 = random(1.0, 3.0);
      gravity = 0;
      speed = v0;
      s = random(15.0, 60.0);
      size = s;

      initFlag = false;
    }
  }

  void draw() {
    shadow.beginDraw();
    shadow.textAlign(CENTER);
    shadow.fill(255);
    shadow.textFont(font);
    shadow.textSize(size);
    shadow.text(jp, x, y);
    shadow.endDraw();

    if (!initFlag) {
      float sinval = sin(angle);
      float gray = map(sinval, -1, 1, 0, 100);
      fill(gray);
      angle += 0.5;
    } else {
      fill(0);
    }    
    text(hg, x, y);

    if (initFlag) {
      size *= 0.8;
    }

    if (size < s) {
      size = s;
    }
  }
}