class LayerScape extends LayerScapeSkeleton{
  private boolean bezier = false;
  private ArrayList<PVector[]> listLine;
  private ArrayList<float[]> listAngles;

  LayerScape(
    int maxIteration,
    color fillColor,
    float[] range,
    float medianY,
    float medianHeight,
    float threshold,
    boolean bezier
  ){
    super(
      maxIteration,
      fillColor,
      range,
      medianY,
      medianHeight,
      threshold
    );
    this.bezier = bezier;
    if(bezier){
      listLine = new ArrayList<PVector[]>();
      listAngles = new ArrayList<float[]>();
      float ang = random(-1 * HALF_PI, 0) - PI;

      for(int i = 1; i < this.Points.size(); i++){
        listLine.add(new PVector[]{
          this.Points.get(i - 1),
          this.Points.get(i),
        });
        PVector dirVector = directionVector(this.Points.get(i - 1), this.Points.get(i));
        float dirAngle = (dirVector.x == 0) ? HALF_PI : atan(dirVector.y / dirVector.x);
        float first = ang + PI;
        float second = dirAngle + random(-1 * HALF_PI, 0);

        listAngles.add(new float[]{ first, second });
        ang = second;
      }
    }
  }

  public void display(PGraphics _g){
    this.displaySkeleton(_g, () -> {
        _g.pushStyle();
          if(!debugLine) _g.noStroke();
          else _g.stroke(0, 0, 0, 128);
          _g.fill(fillColor);
          _g.beginShape();
            if(!this.bezier){
              this.Points.forEach(
                p -> _g.vertex(p.x, p.y)
              );
            }
            else{
              for(int i = 0; i < listLine.size(); i++){
                PVector[] anchors = listLine.get(i);
                float[] angs = listAngles.get(i);
                _g.vertex(anchors[0].x, anchors[0].y);
                _g.bezierVertex(
                  anchors[0].x + 20 * sin(angs[0]), anchors[0].y + 20 * cos(angs[0]),
                  anchors[1].x + 20 * sin(angs[1]), anchors[1].y + 20 * cos(angs[1]),
                  anchors[1].x, anchors[1].y
                );
              }
            }
            _g.vertex(width + outlier, medianY + outlier);
            _g.vertex(width + outlier, medianY + outlier + medianHeight);
            _g.vertex(-outlier, medianY + outlier + medianHeight);
            _g.vertex(-outlier, medianY + outlier);
          _g.endShape(CLOSE);
        _g.popStyle();
      }
    );
  }
}
