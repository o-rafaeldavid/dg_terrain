class ColorLightModel extends ColorPercentageList{
    private ArrayList<Integer> allColors = new ArrayList<Integer>();
    private String lightKind = "";
    private int iterations = -1;

    ColorLightModel(
        ArrayList<ColorPercentage> colorPercentage,
        String lightKind,
        int iterations
    ){
        super(colorPercentage);
        this.lightKind = lightKind;
        this.iterations = iterations;
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
                
                if(this.lightKind == "LINEAR") allColors.add(linearLightLerp(croma, f));
                else allColors.add(exponentialLightLerp(croma, f, 0));
            }
        }
    }

    public ArrayList<Integer> getList(){ return allColors; }
}