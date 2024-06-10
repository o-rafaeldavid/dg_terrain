import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.Set;
import java.util.List;
import gifAnimation.*;

static PApplet MAIN_APPLET;
ArrayList<MyGif> allMyGifs = new ArrayList<MyGif>();
HashMap<String, float[]> gifFPSbySource;

Gradient GRAD;
final int scale = 75;
final int outlier = 300;

ArrayList<GraphicLayer> GL;

ColorLightModel CLM;

PVector thresholdPointer;
void settings(){
  size(21 * scale, 9 * scale);
  MAIN_APPLET = this;
}

void setup(){
  gifFPSbySource = new HashMap<String, float[]>(){{
    // gif Source                      FPS / elevation / size of height relative to viewport
    put("Atreides_Rise.gif", new float[]{5, 0.8, 0.35});
    put("Atreides_siluette.gif", new float[]{10, 0.8, 0.35});
    put("Chani_and_paul.gif", new float[]{5, 0.87, 0.15});
    put("Orinitoptero.gif", new float[]{25, 1.2, 0.35});
    put("Thumper.gif", new float[]{6, 0.95, 0.35});
  }};
  gifFPSbySource.entrySet().forEach(
    entry -> allMyGifs.add(new MyGif(
      entry.getKey(),
      (int) entry.getValue()[0],
      entry.getValue()[1],
      entry.getValue()[2]
    ))
  );

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
  GL = new ArrayList<GraphicLayer>();
  GL.add(
    __terrains.get("Mountain Dune")
  );
  GL.get(0).mapLayersColorWithModel(CLM);
  colorMode(RGB, 255, 255, 255);
}

void keyReleased() {
  if(key == 'D' || key == 'd'){
    GL.forEach(
      gl -> gl.Layers.forEach(
        layer -> { layer.debugPoints = !layer.debugPoints; }
      )
    );
  }
  if(key == 'L' || key == 'l'){
    GL.forEach(
      gl -> gl.Layers.forEach(
        layer -> { layer.debugLine = !layer.debugLine; }
      )
    );
  }

  if(key == 'P' || key == 'p'){
    CLM.changeLightKind("LINEAR");
    GL.get(0).mapLayersColorWithModel(CLM);
  }

  if(key == 'O' || key == 'o'){
    CLM.changeLightKind("EXP");
    GL.get(0).mapLayersColorWithModel(CLM);
  }
}

void draw(){
  thresholdPointer = new PVector(mouseX, mouseY);
  background(255);
  GL.forEach(
    gl -> gl.display()
  );
  
  /* GRAD.display(); */

  /* pushStyle();
    noStroke();
    for(int i = 0; i < CLM.getList().size(); i++){
      fill(CLM.getList().get(i));
      square(i * width / CLM.getList().size(), 40, 40);
    }
  popStyle(); */
}


PVector directionVector(PVector from, PVector to){
  return new PVector(to.x - from.x, to.y - from.y);
}
