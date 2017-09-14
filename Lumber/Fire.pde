class Fire {
  int x, y;
  int ttl=100;
  Fire(int x_, int y_) {
    x=x_;
    y=y_;
  }

  void show() {
    imageMode(CENTER);
    image(fireImage, x, y);
    imageMode(CORNER);
  }

  void spread() {
    if (random(1)<0.1) {
      for (int i=0; i<trees.length; i++) {
        Tree t=trees[i];
        if (dist(t.x, t.y, x, y)<20 && !t.onFire) {
          t.onFire=true;
          spawnFire(t.x, t.y);
        }
      }
    }
  }

  void physics() {
    ttl--;
    if (ttl>0) {
      spread();
    } else {
      for (int i=0; i<fires.length; i++) {
        if (fires[i]==this) {
          fires=(Fire[])removeObject(fires, i);
        }
      }
      for (int i=0; i<trees.length; i++) {
        if (dist(x, y, trees[i].x, trees[i].y)==0) {
          trees=(Tree[])removeObject(trees,i);
        }
      }
    }
  }
}