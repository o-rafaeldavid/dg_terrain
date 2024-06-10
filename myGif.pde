class MyGif{
    private PImage[] allFrames;
    private int counter = 0;
    private PVector dimensions = new PVector(-1, -1);

    private float sketchFrameDuration = -1;
    private float gifFrameDuration = -1;
    private float elapsedTime = 0;

    private float elevate = 1;
    private PGraphics graf;
    private float maxVisibleLength = (float) Integer.MAX_VALUE;

    MyGif(String S, int FPS, float elevate, float multiplierHeight, float maxVisibleLength){
        Set<String> keySet = gifFPSbySource.keySet();
        if(!keySet.contains(S)){
            println("A colocada no construtor MyGif deve estar dentro do keySet do hashMap gifFPSbySource:");
            keySet.forEach(gL -> println(gL));
            println("String enviada: " + S);
            exit();
        }
        this.allFrames = Gif.getPImages(MAIN_APPLET, S);

        this.dimensions.y = height * multiplierHeight;
        this.dimensions.x = this.dimensions.y * ( (float) this.allFrames[0].width / (float) this.allFrames[0].height );

        this.sketchFrameDuration = 1 / (float) frameRate;
        this.gifFrameDuration = 1 / (float) FPS;

        //
        this.elevate = elevate;

        //
        graf = createGraphics((int) this.dimensions.x, (int) this.dimensions.y);
        for(int i = 0; i< this.allFrames.length; i++){
            this.graf.beginDraw();
                this.graf.clear();
                this.graf.image(
                    this.allFrames[i],
                    0, 0,
                    this.graf.width, this.graf.height
                );
                this.graf.filter(INVERT);
            this.graf.endDraw();

            this.graf.updatePixels();
            this.allFrames[i] = this.graf.get();
        }

        //
        this.maxVisibleLength = maxVisibleLength;
    }
    //////

    public float getMaxVisibleLength(){
        return maxVisibleLength * height;
    }

    //
    public void display(PGraphics _g, PVector pos, float scaleFactor, color C){
        PImage frameShow = this.allFrames[this.counter % this.allFrames.length];
        PVector newDimension = new PVector(frameShow.width, frameShow.height).mult(scaleFactor);
        _g.push();
            _g.translate(- 1 * frameShow.width * 0.5, -1 * elevate * newDimension.y);
            _g.translate(pos.x, pos.y);
            _g.tint(C);
            _g.image(
                frameShow,
                0, 0,
                newDimension.x, newDimension.y
            );
            _g.stroke(0, 0, 255);
            _g.strokeWeight(10);
            _g.point(
                frameShow.width * 0.5,
                elevate * newDimension.y
            );
        _g.pop();

        this.elapsedTime += this.sketchFrameDuration;
        if (this.elapsedTime >= this.gifFrameDuration) {
            this.counter++;
            this.elapsedTime -= this.gifFrameDuration;
        }
    }
}
