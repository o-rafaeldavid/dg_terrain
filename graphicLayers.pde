HashMap<String, GraphicLayer> __terrains;

void SETUP__terrains(){
    __terrains = new HashMap<String, GraphicLayer>();
    __terrains.put(
        "Dune",
        new GraphicLayer(0, new ArrayList<>() {{
        float firstY = random(0.8, 0.95) * height;
        for(int i = 0; i < CLM.getList().size(); i++){
            PVector minMax = new PVector(
                map(i, 0, CLM.getList().size(), 5, 30),
                map(i, 0, CLM.getList().size(), 30, 80)
            );
            add(new LayerScape(
                int(random(3, 6)), color(0),
                new float[] {
                    -1 * random(minMax.x, minMax.y),
                    random(minMax.x, minMax.y)
                },
                firstY,
                height - firstY,
                1,
                true
            ));
            firstY -= random(map(CLM.getList().size(), 0, 10, 0.1, 0.01), map(CLM.getList().size(), 0, 10, 0.14, 0.07)) * height;
        }
    }})
    );
}