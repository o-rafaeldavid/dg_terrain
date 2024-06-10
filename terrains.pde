HashMap<String, ArrayList<GraphicLayer>> __terrains;
String[] terrainNames = new String[]{
    "Dune",
    "Mountain Dune"
};

void SETUP__terrains(){
    println("\n============ Dando Setup a Terrenos ============");
    __terrains = new HashMap<String, ArrayList<GraphicLayer>>();
    /////
    /////
    println("\n\n\n");
    println("\n-> Terreno 'Dune'");
    __terrains.put(
        "Dune",
        new ArrayList<GraphicLayer>(){{
            add(new GraphicLayer(0, new ArrayList<LayerScape>(){{
                float firstY = random(0.8, 0.95) * height;
                //
                for(int i = 0; i < CLM.getList().size(); i++){
                    PVector minMax = new PVector(
                        map(i, 0, CLM.getList().size(), 10, 30),
                        map(i, 0, CLM.getList().size(), 50, 80)
                    );
                    add(new LayerScape(
                        int(random(3, 6)), color(0),
                        new float[] {
                            -1 * random(minMax.x, minMax.y),
                            random(minMax.x, minMax.y)
                        },
                        firstY,
                        1,
                        0,
                        0,
                        new ArrayList<MyGif>(),
                        true
                    ));
                    firstY -= random(
                        map(CLM.getList().size(), 0, 10, 0.07, 0.01),
                        map(CLM.getList().size(), 0, 10, 0.14, 0.07)
                    ) * height;
                }
            }}));
        }}
    );
    /////
    /////
    println("\n\n\n");
    println("\n-> Terreno 'Mountain Dune'");
    __terrains.put(
        "Mountain Dune",
        new ArrayList<GraphicLayer>(){{
            add(terrainGLBuilder(
                "Mountain Dune",
                1,
                CLM,
                0,
                (int) ((CLM.getList().size() - 1) * 0.5f)
            ));
            add(terrainGLBuilder(
                "Mountain Dune",
                1,
                CLM,
                (int) ((CLM.getList().size() - 1) * 0.5f),
                CLM.getList().size() - 1
            ));
        }}
    );
    /////
    /////
    println("\n\n\n");
    println("\n============ Setup de Terrenos Finalizado! ============");
}