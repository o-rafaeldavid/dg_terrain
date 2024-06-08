class LayerScape extends LayerScapeSkeleton{
  private boolean bezier = false;
  private PVector[] sideOutlierPoints = new PVector[2];
  private float medianHeight;

  LayerScape(
    int maxIteration,
    color fillColor,
    float[] range,
    float medianY,
    float threshold,
    boolean bezier
  ){
    super(
      maxIteration,
      fillColor,
      range,
      medianY,
      threshold
    );
    this.bezier = bezier;
    this.sideOutlierPoints[0] = new PVector(
      width + outlier,
      this.Points.get(this.Points.size() - 1).y + random(range[0], range[1])
    );
    this.sideOutlierPoints[1] = new PVector(-outlier, medianY);
    this.medianHeight = height - this.medianY;
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

              _g.vertex(this.sideOutlierPoints[0].x, this.sideOutlierPoints[0].y);
              _g.vertex(width + outlier, medianY + outlier + this.medianHeight);
              _g.vertex(-outlier, medianY + outlier + this.medianHeight);
              _g.vertex(this.sideOutlierPoints[1].x, this.sideOutlierPoints[1].y);
            }
            //////
            else{
              _g.curveVertex(this.sideOutlierPoints[1].x, this.sideOutlierPoints[1].y); //ultimo ponto
              this.Points.forEach(
                p -> _g.curveVertex(p.x, p.y)
              );
              _g.curveVertex(this.sideOutlierPoints[0].x, this.sideOutlierPoints[0].y);
              _g.curveVertex(width + outlier, medianY + outlier + this.medianHeight);
              _g.curveVertex(-outlier, medianY + outlier + this.medianHeight);
              _g.curveVertex(this.sideOutlierPoints[1].x, this.sideOutlierPoints[1].y); //ultimo ponto
              //desenhar o primeiro e o segundo para dar a ideia que o caminho fechou
              _g.curveVertex(this.Points.get(0).x, this.Points.get(0).y);
              _g.curveVertex(this.Points.get(1).x, this.Points.get(1).y);
            }

          _g.endShape();
        _g.popStyle();
      }
    );
  }
}
