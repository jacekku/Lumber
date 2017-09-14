//~Hi I'm a tree.and that's how I talk~
//...I respond with a story...
class Tree {
  //...Setting up some values for the tree...
  int x, y, state=0, growth=0, growthThreshold=10;
  int xSize=10, ySize=14;
  int seedlingNumber=5;
  boolean active=false,onFire=false;

  Tree(int x_, int y_) {
    x=x_;
    y=y_;
    active=true;
  }
  //~Showing myself~
  void show() {
    //...if you are alive...
    if (active) {
      //...change the image mode to better represent the position...
      //...now it's upper left corner...
      //->0===0
      //  |   |
      //  | 0 |
      //  |   |
      //  0===0
      //...changing to CENTER...
      //  0===0
      //  |   |
      //  | 0<-
      //  |   |
      //  0===0
      //...i would like to draw from BOTTOM-MIDDLE...
      //  0===0
      //  |   |
      //  | 0 |
      //  |   |
      //  0===0
      //    ^
      //    |
      //...wonder how I can do that...
      imageMode(CENTER);
      //...drawing a part of the tree tilesheet/spritesheet...
      //...maybe there is a better way...
      image(treeTilesheet.get(state*10, 0, 10, 14), x, y);
      //...reseting to corner...
      imageMode(CORNER);
    }
  }
  //~Yo, I wanna grow!~
  void handleGrowth() {
    //if you are not grown...
    if (state<4) {
      //...charge your inner energy...
      growth++;
      //...if you reach a threshold...
      if (growth>growthThreshold) {
        //...reset... 
        growth=0;
        //...and reach a new level...
        state++;
      }
    }
    //...if you are not fertile...
    if (seedlingNumber==0) {
      //...might as well die...
      state=5;
      //...setting seddlingNumber to -1 so this logic doesn't trigger all the time...
      seedlingNumber=-1;
    }
    //...if you are dead...
    if (state==5) {
      //...charge your inner energy one more time...
      growth++;
      //...if you reach the threshold again...
      if (growth>growthThreshold) {
        //...just die...
        active=false;
        //...delete yourself from the world...
        //...this causes flickers, don't know how to fix yet...
        for (int i=0; i<trees.length; i++) {
          if (trees[i]==this) {
            trees=(Tree[])removeObject(trees, i);
            break;
          }
        }
      }
    }
  }
  //~I want some children,yo.~
  void handleSeeding() {
    float distance;
    boolean freeSpot=true;
    //if you are grown up...
    if (state==4) {
      //...and get lucky...
      if (random(1)<0.1) {
        //...pick a spot...
        int spot=randInt(possibleSpots.length);
        //...check if the spot is near any other trees...
        for (Tree t : trees) {
          distance=dist(possibleSpots[spot].x, possibleSpots[spot].y, t.x, t.y);
          //...if it is...
          if (distance<15) {
            freeSpot=false;
            //...bail...
            break;
          }
        }//...if not...
        if (freeSpot) {
          //...check distance for some reason...
          distance=dist(possibleSpots[spot].x, possibleSpots[spot].y, x, y);
          //...ok the spot has to be close...
          //...and you have to be fertile...
          if (distance<30 && seedlingNumber>0) {
            //...decrease fertility...
            //...maybe hook this seedling number to fertility...
            seedlingNumber--;
            //...SPAWN THE TREE!...
            spawnTree((int)possibleSpots[spot].x, (int)possibleSpots[spot].y);
            //...And remove the spot from being avaible...
            possibleSpots=removeObject(possibleSpots, spot);
          }
        }
      }
    }
  }

  void handleClick() {
    if (state==4) {
      if (mouseX<x+xSize/2 && mouseX>x-xSize/2 && mouseY<y+ySize/2 && mouseY>y-ySize/2) {
        this.state=5;
      }
    }
  }
}