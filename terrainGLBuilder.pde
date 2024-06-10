GraphicLayer terrainGLBuilder(
    String name,
    int id,
    ColorLightModel _CLM
){
    if(!Arrays.asList(terrainNames).contains(name)){
        println("To use terrainGLBuilder you should use a String from terrainNames");
        println("String used: '" + name + "'");
        println("Possible strings:");
        printArray(terrainNames);
        exit();
        return null;
    }
    else{
        GraphicLayer returnGraphic;
        int clmSize = _CLM.getList().size();
        
        //////
        //////
        println("terreno");
        switch(name){
            ///
            case "Dune":
                returnGraphic = new GraphicLayer(id, new ArrayList<LayerScape>(){{
                    float firstY = random(0.8, 0.95) * height;
                    //
                    for(int i = 0; i < clmSize; i++){
                        PVector minMax = new PVector(
                            map(i, 0, clmSize, 10, 30),
                            map(i, 0, clmSize, 50, 80)
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
                            map(clmSize, 0, 10, 0.07, 0.01),
                            map(clmSize, 0, 10, 0.14, 0.07)
                        ) * height;
                    }
                }});
                returnGraphic.mapLayersColorWithModel(CLM);
                break;
            ///
            default :
                returnGraphic = new GraphicLayer(id, new ArrayList<LayerScape>(){{
                    float firstY = random(0.78, 0.92) * height;
                    //
                    for(int i = 0; i < clmSize; i++){
                        boolean checkMountain = (i >= clmSize * 0.7);
                        PVector minMax = new PVector(
                            map(i, 0, clmSize, (checkMountain) ? 90 : map(i, 0, clmSize * 0.7, 10, 20), (checkMountain) ? 90 : map(i, 0, clmSize * 0.7, 30, 50)),
                            map(i, 0, clmSize, (checkMountain) ? 100 : map(i, 0, clmSize * 0.7, 50, 70), (checkMountain) ? 170 : map(i, 0, clmSize * 0.7, 80, 100))
                        );
                        add(new LayerScape(
                            int(random((checkMountain) ? 5 : 3, (checkMountain) ? 14 : 6)), color(0),
                            new float[] {
                                -1 * random(minMax.x, minMax.y),
                                random(minMax.x, minMax.y)
                            },
                            firstY,
                            1,
                            1,
                            (checkMountain) ? 0 : (int) random(0, 4),
                            new ArrayList<MyGif>(){{
                                add(__gifsMap.get("Thumper.gif"));
                            }},
                            (checkMountain) ? false : true
                        ));
                        firstY -= random(
                            map(clmSize, 0, 10, (checkMountain) ? 0.2 : 0.05, (checkMountain) ? 0.1 : 0.01),
                            map(clmSize, 0, 10, (checkMountain) ? 0.25 : 0.09, (checkMountain) ? 0.2 : 0.05)
                        ) * height;
                    }
                }}, new Gradient(
                        true,
                        new PVector(0, 0),
                        PI / 5,
                        new ArrayList<ColorPercentage>(){{
                            add(new ColorPercentage(color(255, 0, 0, 255), 0.0f));
                            add(new ColorPercentage(color(0, 255, 255, 64), 0.75f));
                            add(new ColorPercentage(color(0, 0, 255, 0), 1.0f));
                        }}
                    ), 7);
                returnGraphic.mapLayersColorWithModel(CLM);
                break;	
        }
        //////
        //////
        println("terreno escolhido");
        return returnGraphic;
    }
}