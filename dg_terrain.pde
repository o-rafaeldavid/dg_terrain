import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.List;
import java.util.Arrays;
import gifAnimation.*;

PGraphics MAIN_GRAPHICS;

Gradient GRAD;
final int scale = 75;
final int outlier = 300;

ArrayList<GraphicLayer> MainGraphics;

ColorLightModel CLM;

PVector thresholdPointer;
void settings(){
  size(21 * scale, 9 * scale);
}

void setup(){
  println("============ SETUP INICIALIZADO ============");
  MAIN_APPLET = this;
  SETUP__gifsMap();
  
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
    monoHueTones.get(1),
    "EXP",
    10
  );

  GRAD = new Gradient(
    true,
    new PVector(0, 0),
    PI / 5,
    new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(255, 0, 0, 255), 0.0f));
      add(new ColorPercentage(color(0, 255, 255, 64), 0.75f));
      add(new ColorPercentage(color(0, 0, 255, 0), 1.0f));
    }}
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
  MainGraphics.forEach(
    gl -> gl.display()
  );
}


PVector directionVector(PVector from, PVector to){
  return new PVector(to.x - from.x, to.y - from.y);
}
