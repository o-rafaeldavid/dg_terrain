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
            add(terrainGLBuilder(
                "Dune",
                1,
                CLM
            ));
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
                CLM
            ));
        }}
    );
    /////
    /////
    println("\n\n\n");
    println("\n============ Setup de Terrenos Finalizado! ============");
}