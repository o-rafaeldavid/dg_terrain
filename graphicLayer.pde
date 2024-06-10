class GraphicLayer{
    public int layerID;
    public PGraphics _g;
    private ArrayList<LayerScape> Layers;

    GraphicLayer(int layerID, ArrayList<LayerScape> Layers){
        this.layerID = layerID;
        this.Layers = Layers;

        this._g = createGraphics(width, height);

        this.orderLayers();
    }

    private void orderLayers(){
        if(this.Layers.size() > 1){
            PVector thresholdRange = new PVector(random(0.7, 0.94), random(0.2, 0.3));
            PVector heights = new PVector(this.Layers.get(0).getHeight(), -1);
            this.Layers.forEach(layer -> {
                float layerHeight = layer.getHeight();
                if(heights.x > layerHeight) heights.x = layerHeight;
                if(heights.y < layerHeight) heights.y = layerHeight;
            });

            Collections.sort(this.Layers, new Comparator<LayerScape>() {
                public int compare(LayerScape l1, LayerScape l2) {
                    return Float.compare(l1.getHeight(), l2.getHeight());
                }
            });

            for(int index = 0; index < this.Layers.size(); index++){
                LayerScape layer = this.Layers.get(index);
                layer.setOrder(index, this.Layers.size());
                layer.threshold = map(
                    layer.getHeight(),
                    heights.x, heights.y,
                    thresholdRange.x, thresholdRange.y
                );
                println((index + 1) + " / " + this.Layers.size());
                if(layer.layerBefore == null){
                    layer.layerBefore = (index == this.Layers.size() - 1) ? null : this.Layers.get(index + 1);
                    layer.genGifs();
                    println("--> GraphicLayer: Gifs Gerados");
                }
                else println("--> GraphicLayer: Já tem a «layer encima» associada");
            }
        }
    }

    public void mapLayersColorWithModel(ColorLightModel _CLM, int from, int to){
        ArrayList<Integer> colorsList = _CLM.getList();
        if(colorsList.size() <= this.Layers.size() || from < 0 || to > colorsList.size() || from >= to){
            println("GraphicLayer mapColorWithModel Method should get a ColorLightModel object with the same size or less of the Layers inside GraphicLayer");
            println("Given ColorLightModel Length: " + colorsList.size());
            println("Layers array Length: " + this.Layers.size());
            println("The 'from' and 'to' components of mapLayersColorWithModel method from GraphicLayer should be between 0 and the size of ColorLightModel used");
            println("'from' should be less than 'to'");
            println("From: " + from + " | To: " + to);
            println("Size of CLM: " + colorsList.size());
            exit();
        }
        else{
            for(int i = from; i < to; i++){
                this.Layers.get(i).fillColor = colorsList.get(colorsList.size() - 1 - i);
            }
        }
    }

    public void display(){
        this._g.beginDraw();
            this._g.clear();
            this.Layers.forEach(layer -> layer.display(_g));
        this._g.endDraw();
        this._g.updatePixels();
        image(this._g, 0, 0);
    }
}