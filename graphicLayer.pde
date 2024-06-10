class GraphicLayer{
    public int layerID;
    public PGraphics _g;
    private ArrayList<LayerScape> Layers;
    private Gradient gradientAbove;
    private int gradOrder;

    GraphicLayer(int layerID, ArrayList<LayerScape> Layers){
        this.layerID = layerID;
        this.Layers = Layers;

        this._g = createGraphics(width, height);

        this.orderLayers();
    }

    GraphicLayer(int layerID, ArrayList<LayerScape> Layers, Gradient gradientAbove, int gradOrder){
        this.layerID = layerID;
        this.Layers = Layers;

        if(!(gradOrder >= 0 && gradOrder < this.Layers.size())){
            println("You should define gradOrder between 0 and last Layer index!");
            println("Last Layer index: " + (this.Layers.size() - 1));
            println("gradOrder given: " + gradOrder);
            exit();
        }
        else if(gradientAbove == null){
            println("gradientAbove prop from GraphicLayer should not be null!");
            exit();
        }

        this._g = createGraphics(width, height);

        this.orderLayers();

        println("--> GraphicLayer: Degradê inicializado");
        this.gradOrder = gradOrder;
        this.gradientAbove = gradientAbove;
        println("--> GraphicLayer: Degradê finalizado");
    }
    ///

    private void orderLayers(){
        if(this.Layers.size() > 1){
            println("--> GraphicLayer: Iniciando ordenação de Layers");
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
            
            println("--> GraphicLayer: Ordenação de Layers Finalizada");
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
            for(int index = 0; index < this.Layers.size(); index++){
                this.Layers.get(index).display(_g);
                if(this.gradientAbove != null && this.gradOrder == index){
                    //this.Layers.get(index).display(_g);
                    /* _g.tint(255, 128); */
                    this.gradientAbove.display(_g);
                }
            }
        this._g.endDraw();
        this._g.updatePixels();
        image(this._g, 0, 0);
    }
}