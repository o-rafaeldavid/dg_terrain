import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.List;
import java.util.Arrays;
import gifAnimation.*;

PGraphics MAIN_GRAPHICS;

final int scale = 75;
final int outlier = 300;

ArrayList<GraphicLayer> MainGraphics;

ColorLightModel CLM;
int clmIndex = -1;
String lightKind = "";

PVector thresholdPointer;

///
void settings(){
  size(21 * scale, 9 * scale);
}

void setup(){
  println("============ SETUP INICIALIZADO ============");
  MAIN_APPLET = this;
  SETUP__gifsMap();
  SETUP_SKY();
  clmIndex = (int) random(tones.size());
  lightKind = (clmIndex > 3) ? "LINEAR" : (random(1) < 0.5f) ? "EXP" : "LINEAR";
  sky.get(clmIndex).loadGradient();
  
  thresholdPointer = new PVector(width * 0.5, height * 0.5);
  colorMode(HSB, 360, 100, 100);
  /* three_color = new ArrayList<color[]>(){{
    add(new color[] {
      color(211, 17, 30),
      color(5, 15, 58),
      color(20, 6, 19),
    });
  }}; */
  colorMode(RGB, 255, 255, 255);

  CLM = new ColorLightModel(
    tones.get(clmIndex),
    lightKind,
    10,
    new float[]{random(0, 20), random(50, 100)}
  );

  SETUP__terrains();

  colorMode(HSB, 360, 100, 100);
    MainGraphics = new ArrayList<GraphicLayer>();
    MainGraphics = __terrains.get("Mountain Dune");
  colorMode(RGB, 255, 255, 255);
  println("============ SETUP FINALIZADO ============");
}

void keyReleased() {
  if(key == 'D' || key == 'd'){
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
  }
}

void draw(){
  thresholdPointer = new PVector(mouseX, mouseY);
  background(255);
  sky.get(clmIndex).display(this.g);
  MainGraphics.forEach(
    gl -> gl.display()
  );
}


PVector directionVector(PVector from, PVector to){
  return new PVector(to.x - from.x, to.y - from.y);
}
