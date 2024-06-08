class LayerScapeSkeleton{
    protected ArrayList<PVector> Points = new ArrayList<PVector>();
    private float myHeight = -1;
    public int maxIteration;
    public color fillColor;
    public float[] range;
    public float medianY;
    public float medianHeight;
    public float threshold;
    public boolean debugPoints = false;
    public boolean debugLine = false;
    
    protected boolean bezier = false;

    LayerScapeSkeleton(
        int maxIteration,
        color fillColor,
        float[] range,
        float medianY,
        float threshold
    ){
        this.maxIteration = maxIteration;
        this.fillColor = fillColor;
        this.range = range;
        this.medianY = medianY;
        this.threshold = threshold;
        this.setPoints();
    }

    public float getHeight(){
        return myHeight;
    }

    private void setPoints(){
        PVector prevPoint = new PVector(0, medianY);
        for(int i = 0; i <= maxIteration; i++){
            final float y_increment = random(range[0], range[1]);
            final PVector genP = new PVector((width * i) / (float) (maxIteration), prevPoint.y + y_increment);
            Points.add(genP);
            if(genP.y > myHeight) myHeight = genP.y;
            prevPoint = genP;
        }
    }

    protected void debugPoints(PGraphics _g){
        //debugPoints
        if(debugPoints){
            _g.pushStyle();
            _g.stroke(255, 0, 0);
            _g.strokeWeight(10);
            Points.forEach(
                p -> _g.point(p.x, p.y)
            );
            _g.popStyle();
        }
    }

    protected void displaySkeleton(PGraphics _g, Runnable fun){
        _g.beginDraw();
            _g.pushMatrix();
                _g.translate(
                    map(
                        thresholdPointer.x,
                        width * 0.5, width,
                        0, outlier * 0.15 / this.threshold
                    ),
                    map(
                        thresholdPointer.y,
                        height * 0.5, height,
                        0, outlier * 0.03 / this.threshold
                    )
                );
                    //
                    fun.run();
                    //
                    this.debugPoints(_g);
            _g.popMatrix();
        _g.endDraw();
    }
}