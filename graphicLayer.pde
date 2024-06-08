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
        if(Layers.size() > 1){
            PVector thresholdRange = new PVector(random(0.7, 0.94), random(0.2, 0.3));
            PVector heights = new PVector(Layers.get(0).getHeight(), -1);
            Layers.forEach(layer -> {
                float layerHeight = layer.getHeight();
                println(layerHeight);
                if(heights.x > layerHeight) heights.x = layerHeight;
                if(heights.y < layerHeight) heights.y = layerHeight;
            });

            Collections.sort(Layers, new Comparator<LayerScape>() {
                public int compare(LayerScape l1, LayerScape l2) {
                    return Float.compare(l1.getHeight(), l2.getHeight());
                }
            });

            println("======");
            Layers.forEach(layer -> {
                println(layer.getHeight());
                layer.threshold = map(
                    layer.getHeight(),
                    heights.x, heights.y,
                    thresholdRange.x, thresholdRange.y
                );
            });
        }
    }

    public void mapLayersColorWithModel(ColorLightModel _CLM){
        ArrayList<Integer> colorsList = _CLM.getList();
        if(colorsList.size() != this.Layers.size()){
            println("GraphicLayer mapColorWithModel Method should get a ColorLightModel object with the same size of the Layers inside GraphicLayer");
            println("Given ColorLightModel Length: " + colorsList.size());
            println("Layers array Length: " + this.Layers.size());
            exit();
        }
        else{
            for(int i = 0; i < colorsList.size(); i++){
                this.Layers.get(i).fillColor = colorsList.get(colorsList.size() - 1 - i);
            }
        }
    }

    public void display(){
        this._g.beginDraw();
            this._g.clear();
            Layers.forEach(layer -> layer.display(_g));
        this._g.endDraw();
        this._g.updatePixels();
        image(this._g, 0, 0);
    }
}