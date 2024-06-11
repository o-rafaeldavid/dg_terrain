static PApplet MAIN_APPLET;
/* ArrayList<MyGif> allMyGifs = new ArrayList<MyGif>(); */
HashMap<String, float[]> gifFPSbySource;
HashMap<String, MyGif> __gifsMap;

String[] gifNames = new String[]{
    "Atreides_Rise.gif",
    "Atreides_siluette_2.gif",
    "Atreides_siluette.gif",
    "Chani_and_paul.gif",
    "Freman.gif",
    "Muad'ib.gif",
    "Revelation.gif",
    "SandWalking.gif",
    "sardukar.gif",
    "Stilgar.gif",
    "Stilgar_Paul.gif",
    "Thumper.gif",
    "Waiting for Worm.gif",
    "Orinitoptero.gif",
    "Ornitopther_2.gif",
};

void SETUP__gifsMap(){
    println("\n============ Dando Setup a Gifs ============");
    gifFPSbySource = new HashMap<String, float[]>(){{
        // gif Source                       FPS / elevation / size of height relative to viewport / max gap from visible layer "top-side" between layers / dimHeight
        put("Atreides_Rise.gif",            new float[]{24, 0.97, 0.27, 0.03});
        put("Atreides_siluette_2.gif",      new float[]{24, 0.92, 0.27, 0.03});
        put("Atreides_siluette.gif",        new float[]{24, 0.92, 0.27, 0.03});
        put("Chani_and_paul.gif",           new float[]{24, 0.95, 0.23, 0.03});
        put("Freman.gif",                   new float[]{18, 0.95, 0.3, 0.03});
        put("Muad'ib.gif",                  new float[]{18, 0.95, 0.2, 0.03});
        put("Orinitoptero.gif",             new float[]{24, 1.2, 0.25, 0.03});
        put("Ornitopther_2.gif",            new float[]{24, 1.2, 0.25, 0.03});
        put("Revelation.gif",               new float[]{18, 0.95, 0.23, 0.03});
        put("SandWalking.gif",              new float[]{16, 0.95, 0.27, 0.03});
        put("sardukar.gif",                 new float[]{24, 1, 0.45, 0.07});
        put("Stilgar.gif",                  new float[]{24, 0.95, 0.23, 0.03});
        put("Stilgar_Paul.gif",             new float[]{24, 0.95, 0.3, 0.03});
        put("Thumper.gif",                  new float[]{12, 0.95, 0.25, 0.03});
        put("Waiting for Worm.gif",         new float[]{24, 0.95, 0.25, 0.03});
    }};

    __gifsMap = new HashMap<String, MyGif>(){{
        gifFPSbySource.entrySet().forEach(
            entry -> {
                /* allMyGifs.add(new MyGif(
                    entry.getKey(),
                    (int) entry.getValue()[0],
                    entry.getValue()[1],
                    entry.getValue()[2],
                    entry.getValue()[3]
                )); */
                println("\n\n\n");
                println("\n" + entry.getKey());
                put(
                    entry.getKey(),
                    new MyGif(
                        entry.getKey(),
                        (int) entry.getValue()[0],
                        entry.getValue()[1],
                        entry.getValue()[2],
                        entry.getValue()[3]
                    )
                );
            }
        );
    }};
    println("\n\n\n");
    println("\n============ Setup de Gifs Finalizado! ============");
}