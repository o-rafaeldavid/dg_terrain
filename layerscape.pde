class LayerScape extends LayerScapeSkeleton{
  private boolean bezier = false;
  private PVector[] sideOutlierPoints = new PVector[2];
  private float medianHeight;

  private ArrayList<Gif> GifList = new ArrayList<Gif>();
  private ArrayList<PVector> GifPoints = new ArrayList<PVector>();
  public LayerScape layerBefore = null;

  LayerScape(
    int maxIteration,
    color fillColor,
    float[] range,
    float medianY,
    float threshold,
    float probGifPerIteration,
    float maxGifNum,
    boolean bezier
  ){
    super(
      maxIteration,
      fillColor,
      range,
      medianY,
      threshold,
      probGifPerIteration,
      maxGifNum
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

          doGif(_g);
        _g.popStyle();
      }
    );
  }

  private PVector getRandomVisiblePoint(){
    if(layerBefore == null) return null;
    else{
      PVector visiblePoint = new PVector(-1, -1);
      boolean finished = false;
      while(!finished){
        println("AI CICLO");
        float randX = random(0, width);

        PVector thisSegmentPoint = new PVector(-1, -1);
        PVector otherSegmentPoint = new PVector(-1, -1);

        for(int k = 0; k <= 1; k++){
          ArrayList<PVector> pointsToManage = (k == 0) ? this.Points : layerBefore.getPoints();

          for(int index = 1; index < pointsToManage.size(); index++){
            PVector prevPoint = pointsToManage.get(index - 1);
            PVector nowPoint = pointsToManage.get(index);

            if(prevPoint.x <= randX && randX < nowPoint.x){
              println("EPA ENTREI AQUI");
              float factor = (randX - prevPoint.x) / (nowPoint.x - prevPoint.x);
              PVector P = PVector.lerp(prevPoint, nowPoint, factor);

              if(k == 0) thisSegmentPoint = P;
              else otherSegmentPoint = P;

              break;
            }
          }
        }

        println(thisSegmentPoint);
        println(otherSegmentPoint);

        if(otherSegmentPoint.y > thisSegmentPoint.y){
          finished = true;
          visiblePoint = new PVector(randX, random(thisSegmentPoint.y, otherSegmentPoint.y));
        }
      }
      return visiblePoint;
    }
  }

  public void genGifs(){
    for(int k = 0; k < maxGifNum; k++){
      GifPoints.add(this.getRandomVisiblePoint());
    }
    println("============ GifPoints Salvos ============");
    println(GifPoints);
  }

  private void doGif(PGraphics _g){
    _g.pushStyle();
      _g.stroke(0, 0, 255);
      _g.strokeWeight(10);
      GifPoints.forEach(
        gP -> {if(gP != null) _g.point(gP.x, gP.y);}
      );
    _g.popStyle();
  }
}
