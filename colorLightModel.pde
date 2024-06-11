class ColorLightModel extends ColorPercentageList{
    private ArrayList<Integer> allColors = new ArrayList<Integer>();
    private String lightKind = "";
    private int iterations = -1;
    private float[] minMaxBright;

    ColorLightModel(
        ArrayList<ColorPercentage> colorPercentage,
        String lightKind,
        int iterations,
        float[] minMaxBright
    ){
        super(colorPercentage);
        if(lightKind != "LINEAR" && lightKind != "EXP"){
            println("Light kind should be 'LINEAR' or 'EXP'");
            println("- Given lightKind: " + lightKind);
            exit();
        }
        this.lightKind = lightKind;
        this.iterations = iterations;
        this.minMaxBright = minMaxBright;
        if(this.iterations <= this.colorPercentage.size()){
            println("Color Model iterations should be equal or higher than the number of colors given to model!");
            println("- Given colors: " + this.colorPercentage.size());
            println("- Iterations: " + this.iterations);
            exit();
        }
        
        this.generateColors();
    }

    private void generateColors(){
        for(int i = 0; i < this.colorPercentage.size() - 1; i++){
            ColorPercentage firstCp = this.colorPercentage.get(i);
            ColorPercentage nextCp = this.colorPercentage.get(i + 1);

            for(float f = firstCp.percentage; f < nextCp.percentage; f += 1 / (float) this.iterations){
                float lerp = constrain(map(f, firstCp.percentage, nextCp.percentage, 0, 1), 0, 0.99);
                color croma = lerpColor(firstCp.croma, nextCp.croma, lerp);
                
                if(this.lightKind == "LINEAR") allColors.add(linearLightLerp(croma, f, this.minMaxBright[0], this.minMaxBright[1]));
                else allColors.add(exponentialLightLerp(croma, f, this.minMaxBright[0], this.minMaxBright[1]));
            }
        }
    }

    public ArrayList<Integer> getList(){ return allColors; }
    public void changeLightKind(String lightKind){
        if(lightKind != "LINEAR" && lightKind != "EXP"){
            println("Light kind should be 'LINEAR' or 'EXP'");
            println("- Given lightKind: " + lightKind);
            exit();
        }
        this.lightKind = lightKind;
        this.allColors = new ArrayList<Integer>();
        this.generateColors();
    }
    public String getKind(){ return lightKind; }
}