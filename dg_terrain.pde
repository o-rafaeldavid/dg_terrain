import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.List;
import java.util.Arrays;
import java.io.File;
import gifAnimation.*;

PGraphics MAIN_GRAPHICS;

final int scale = 75;
final int outlier = 300;

ArrayList<GraphicLayer> MainGraphics;

ColorLightModel CLM;
int clmIndex = -1;
String lightKind = "";

PVector thresholdPointer;

int TEMPO = 1;
int FRAME_RATE = 60;
int frameCounter = 0;
String folderPath = "";

///
void settings(){
  size(21 * scale, 9 * scale);
}

void setup(){
  println("============ SETUP INICIALIZADO ============");
  frameRate(FRAME_RATE);
  
  println("============ DIRETORIO CRIADO ============");
  folderPath = System.currentTimeMillis() + "";
  File folder = new File(folderPath);
  if (!folder.exists()) {
    folder.mkdir();
  }

  MAIN_APPLET = this;
  SETUP__gifsMap();
  SETUP_SKY();
  clmIndex = (int) random(tones.size());
  lightKind = (clmIndex > 3) ? "LINEAR" : (random(1) < 0.5f) ? "EXP" : "LINEAR";
  sky.get(clmIndex).loadGradient();
  
  thresholdPointer = new PVector(width * 0.5, height * 0.5);

  CLM = new ColorLightModel(
    tones.get(clmIndex),
    lightKind,
    10,
    new float[]{random(0, 20), random(50, 100)}
  );

  SETUP__terrains();

  colorMode(HSB, 360, 100, 100);
    MainGraphics = new ArrayList<GraphicLayer>();
    MainGraphics = __terrains.get((random(1) < 0.5f) ? "Dune" : "Mountain Dune");
  colorMode(RGB, 255, 255, 255);
  println("============ SETUP FINALIZADO ============");
}

void keyReleased() {
  /* if(key == 'D' || key == 'd'){
    MainGraphics.forEach(
      gl -> gl.Layers.forEach(
        layer -> { layer.debugPoints = !layer.debugPoints; }
      )
    );
  }
  if(key == 'L' || key == 'l'){
    MainGraphics.forEach(
      gl -> gl.Layers.forEach(
        layer -> { layer.debugLine = !layer.debugLine; }
      )
    );
  } */
  keys[key] = false;

  if(key == 'n' || key == 'N'){
    noLoop();
    File folder = new File(folderPath);
    if (folder.isDirectory()) {
      File[] files = folder.listFiles();
      if (files != null) {
        for (File file : files) {
          file.delete();
        }
      }
    }
    folder.delete();
    println("============ ELIMINADO ============");
    /* exit(); */
  }
}

boolean[] keys = new boolean[256];
void keyPressed(){
  keys[key] = true;
}

void draw(){
  if(frameCounter == FRAME_RATE * TEMPO){
    println("============ FINALIZADO ============");
    exit();
  }
  background(255);
  if(keys['a'] || keys['A']){
    thresholdPointer.x = thresholdPointer.x - random(7, 35);
  }
  if(keys['d'] || keys['D']){
    thresholdPointer.x = thresholdPointer.x + random(7, 35);
  }
  if(keys['w'] || keys['w']){
    thresholdPointer.y = thresholdPointer.y - random(7, 35);
  }
  if(keys['s'] || keys['S']){
    thresholdPointer.y = thresholdPointer.y + random(7, 35);
  }
  sky.get(clmIndex).display(this.g);
  MainGraphics.forEach(
    gl -> gl.display()
  );

  println(frameCount / FRAME_RATE);
  saveFrame(folderPath + "/frame_" + nf(frameCounter, 5) + ".png");
  frameCounter++;
}


PVector directionVector(PVector from, PVector to){
  return new PVector(to.x - from.x, to.y - from.y);
}
