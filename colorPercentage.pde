class ColorPercentage{
    public color croma;
    public float percentage;
    ColorPercentage(color croma, float percentage){
        this.croma = croma;
        this.percentage = percentage;
    }
}

class ColorPercentageList{
    protected ArrayList<ColorPercentage> colorPercentage;

    ColorPercentageList(ArrayList<ColorPercentage> colorPercentage){
        if(colorPercentage.size() < 2){
            println("\n=====\nERROR: you must create a Gradient with more than or equal to 2 colors");
            exit();
        }
        else{
            Collections.sort(colorPercentage, new Comparator<ColorPercentage>() {
                public int compare(ColorPercentage cp1, ColorPercentage cp2) {
                    return Float.compare(cp1.percentage, cp2.percentage);
                }
            });
        }
        
        this.colorPercentage = colorPercentage;
    }
}