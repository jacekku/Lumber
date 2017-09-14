//...Setting up some values...
//...Image variables...
PImage treeTilesheet, axeImage, saplingImage, fireImage, fireBtnImage, map;
//...Buttons array...
Button[] buttons=new Button[3];
//...Tree array...
Tree[] trees=new Tree[0];
//...Fire array...
Fire[] fires=new Fire[0];
//...0=chopping wood,1=planting...
int mouseAction=0;
//...
PVector[] possibleSpots=new PVector[0];

void setup() {
  //...Loading the images...
  treeTilesheet=loadImage("/assets/treeTilesheet.png");
  axeImage=loadImage("/assets/axe.png");
  saplingImage=loadImage("/assets/sapling.png");
  fireImage=loadImage("/assets/fireSprite.png");
  fireBtnImage=loadImage("/assets/fire.png");
  map=loadImage("/assets/map.png");
  //...setting the size of the window using the map dimensions...
  surface.setSize(map.width, map.height);
  //fullScreen();


  //...Check the avaible planting spots...
  checkSpots();
  //...print out the length...
  println(possibleSpots.length);
  //...pregenerate some trees (dependant on the trees length)...
  for (int i=0; i<trees.length; i++) {
    int spot=randInt(possibleSpots.length);
    spawnTree((int)possibleSpots[spot].x, (int)possibleSpots[spot].y);
    possibleSpots=removeObject(possibleSpots, spot);
  }
  //...add the buttons to the array
  buttons[0]=new Button(10, 10, axeImage, 0);
  buttons[1]=new Button(10+saplingImage.width, 10, saplingImage, 1);
  buttons[2]=new Button(10+fireBtnImage.width*2, 10, fireBtnImage, 2);
}

void draw() {
  //...draw the map image...
  image(map, 0, 0);
  //...handle the trees...
  for (Tree t : trees) {
    t.show();
    t.handleGrowth();
    t.handleSeeding();
  }
  //...handle the buttons...
  for (Button b : buttons) {
    b.show();
  }
  for (Fire f : fires) {
    f.show();
    f.physics();
  }
}

void mousePressed() {
  for (Button b : buttons) {
    b.handleClick();
  }
  if (mouseAction==0) {
    for (Tree t : trees) {
      t.handleClick();
    }
  }
  //...If you have planting selected...
  if (mouseAction==1) {
    for (int i=0; i<possibleSpots.length; i++) {
      //...check if you clicked on one of the plantable spots...
      if (possibleSpots[i].x==mouseX && possibleSpots[i].y==mouseY) {
        //...spawn the tree,pretty self-explanatory...
        spawnTree(mouseX, mouseY);
        //...some debug printlines...
        //println(possibleSpots.length);
        //...remove the spot you just planted the tree at...
        possibleSpots=removeObject(possibleSpots, i);
        //...next debug line so i know the removal worked...
        //println(possibleSpots.length);
      }
    }
  }
  if (mouseAction==2) {
    for (int i=0; i<possibleSpots.length; i++) {
      if (possibleSpots[i].x==mouseX && possibleSpots[i].y==mouseY) {
        spawnFire(mouseX, mouseY);
      }
    }
  }
}
//...random integer generator...
int randInt(int end) {
  return randInt(0, end);
}
int randInt(int start, int end) {
  return (int)(random(start, end));
}


//...a function to remove objects from an array of objects...
//...ther were some online but they didnt work so i made my own...
Object[] removeObject(Object[] array, int index) {
  for (int i=index; i<array.length-1; i++) {
    array[i]=array[i+1];
  }
  array=(Object[])shorten(array);
  return array;
}
//...same thing for the vector arrays...
PVector[] removeObject(PVector[] array, int index) {
  for (int i=index; i<array.length-1; i++) {
    array[i]=array[i+1];
  }
  array=(PVector[])shorten(array);
  return array;
}
//...spawn tree function
void spawnTree(int x, int y) {
  Tree t=new Tree(x, y);
  trees=(Tree[])append(trees, t);
}

void spawnFire(int x_, int y_) {
  Fire f=new Fire(x_, y_);
  fires=(Fire[])append(fires, f);
}




//...at the beginning check all the available spots on the map image...
//...using the specific color of green...
void checkSpots() {
  for (int x=0; x<map.width; x++) {
    for (int y=0; y<map.height; y++) {
      //...                         VV  this one VV ...
      if (map.pixels[x+y*map.width]==color(38, 127, 0)) {
        possibleSpots=(PVector[])append(possibleSpots, new PVector(x, y));
      }
    }
    float loadingValue=floor((x/(float)map.width)*100);
    println("Loading", loadingValue, "%");
    fill(color(0, 255, 0));
  }
}