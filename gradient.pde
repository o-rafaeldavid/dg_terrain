class Gradient extends ColorPercentageList{
    private boolean kind;
    private PVector pos;
    private float rot;
    private PGraphics _g;
    private PImage _img;
    private boolean isLoaded = false;

    Gradient(boolean kind, PVector pos, float rot, ArrayList<ColorPercentage> colorPercentage){
        super(colorPercentage);
        this.kind = kind;
        this.pos = pos;
        this.rot = rot;

        this._g = createGraphics(2 * width, round(height + (float) width * (float) sin(rot)));
    }

    private void loadGradient(){
        this._g.beginDraw();
            this._g.clear();
            this._g.pushMatrix();
                this._g.translate(this._g.width * .5f, this._g.height * .5f);
                this._g.rotate(this.rot);
                this._g.translate(-1 * this._g.width * .5f, -1 * this._g.height * .5f);

                this._g.translate(this.pos.x, this.pos.y);
                this._g.pushStyle();
                    this._g.noStroke();
                    for(int i = 0; i < this.colorPercentage.size() - 1; i++){
                        ColorPercentage firstCp = this.colorPercentage.get(i);
                        ColorPercentage nextCp = this.colorPercentage.get(i + 1);

                        for(float f = firstCp.percentage; f < nextCp.percentage; f += 0.5 / (float) this._g.height){
                            float y = map(f, 0, 1, 0, this._g.height);
                            float lerp = constrain(map(f, firstCp.percentage, nextCp.percentage, 0, 1), 0, 0.99);
                            color croma = lerpColor(firstCp.croma, nextCp.croma, lerp);

                            this._g.stroke(croma);
                            this._g.strokeWeight(1);

                            if(this.kind) this._g.line(0, y, this._g.width, y);
                            else{
                                this._g.noFill();
                                this._g.circle(0, 0, y);
                            }
                        }
                    }
                this._g.popStyle();
            this._g.popMatrix();
        this._g.endDraw();
        this._g.filter(BLUR, 3);

        this._g.updatePixels();
        this._img = this._g.get();
        this.isLoaded = true;
    }

    public void display(PGraphics _g){
        if(this.isLoaded){
            _g.push();
                _g.imageMode(CENTER);
                _g.image(this._img, width * .5f, height * .5f);
            _g.pop();
        }
        else{
            println("Gradient should be loaded using method loadGradient");
            exit();
        }
    }
}