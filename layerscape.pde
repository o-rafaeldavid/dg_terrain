class LayerScape extends LayerScapeSkeleton{
  private int maxLayer = -1;
  private int layerOrder = -1;
  private boolean bezier = false;
  private PVector[] sideOutlierPoints = new PVector[2];
  private float medianHeight;

  private ArrayList<MyGif> GifList = new ArrayList<MyGif>();
  private ArrayList<PVector> GifPoints = new ArrayList<PVector>();
  private ArrayList<MyGif> GifsToChoice = new ArrayList<MyGif>();

  public LayerScape layerBefore = null;

  LayerScape(
    int maxIteration,
    color fillColor,
    float[] range,
    float medianY,
    float threshold,
    float probGifPerIteration,
    float maxGifNum,
    ArrayList<MyGif> GifsToChoice,
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
    this.GifsToChoice = GifsToChoice;
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

          this.doGif(_g);
        _g.popStyle();
      }
    );
  }

  private PVector getRandomVisiblePoint(float maxVisibleLength){
    if(layerBefore == null) return null;
    else{
      PVector visiblePoint = new PVector(-1, -1);
      boolean finished = false;
      while(!finished){
        float randX = random(0, width);

        PVector thisSegmentPoint = new PVector(-1, -1);
        PVector otherSegmentPoint = new PVector(-1, -1);

        for(int k = 0; k <= 1; k++){
          ArrayList<PVector> pointsToManage = (k == 0) ? this.Points : layerBefore.getPoints();

          for(int index = 1; index < pointsToManage.size(); index++){
            PVector prevPoint = pointsToManage.get(index - 1);
            PVector nowPoint = pointsToManage.get(index);

            if(prevPoint.x <= randX && randX < nowPoint.x){
              float factor = (randX - prevPoint.x) / (nowPoint.x - prevPoint.x);
              PVector P = PVector.lerp(prevPoint, nowPoint, factor);

              if(k == 0) thisSegmentPoint = P;
              else otherSegmentPoint = P;

              break;
            }
          }
        }

        if(otherSegmentPoint.y > thisSegmentPoint.y){
          finished = true;
          float deltaY = otherSegmentPoint.y - thisSegmentPoint.y;
          float maxDelta = (deltaY > maxVisibleLength) ? maxVisibleLength : deltaY;
          visiblePoint = new PVector(randX, random(thisSegmentPoint.y, thisSegmentPoint.y + maxDelta));
        }
      }
      return visiblePoint;
    }
  }

  public void genGifs(){
    println("--> LayerScape: gerando gifs na Layer");
    if(this.GifsToChoice.size() >= 1 && maxGifNum == 0){
      for(int k = 0; k <= maxGifNum; k++){
        if(random(0, 1) < probGifPerIteration){

          MyGif randomGifChosen = this.GifsToChoice.get((int) random(0, GifsToChoice.size()));
          PVector P = this.getRandomVisiblePoint(randomGifChosen.getMaxVisibleLength());
          GifPoints.add(P);
          if(P != null) GifList.add(randomGifChosen);
        }
      }
      println("--> LayerScape: gifs criados [ " + GifList.size() + " gifs ]");
    }
    else{
      println("--> LayerScape: não há gifs");
    }
  }

  public void setOrder(int layerOrder, int maxLayer){
    this.layerOrder = layerOrder;
    this.maxLayer = maxLayer;
  }

  private void doGif(PGraphics _g){
    _g.push();
      _g.stroke(0, 0, 255);
      _g.strokeWeight(10);
      for(int i = 0; i < GifPoints.size(); i++){
        PVector point = GifPoints.get(i);
        if(point != null) GifList.get(i).display(
                            _g,
                            point,
                            (maxLayer != -1 && layerOrder != -1) ? map(layerOrder, 0, maxLayer, 0.3, 1) : 1,
                            this.fillColor
                          );
      }
    _g.pop();
  }
}
