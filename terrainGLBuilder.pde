GraphicLayer terrainGLBuilder(
    String name,
    int id,
    ColorLightModel _CLM,
    int from,
    int to
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
        if(from >= to || from < 0 || to > clmSize || to <= 0 || from >= clmSize){
            println("The 'from' and 'to' components of terrainGLBuilder should be between 0 and the size of ColorLightModel used");
            println("'from' should be less than 'to'");
            println("From: " + from + " | To: " + to);
            println("Size of CLM: " + clmSize);
            exit();
        }
        
        //////
        //////
        switch(name){
            ///
            case "Dune":
                returnGraphic = new GraphicLayer(id, new ArrayList<LayerScape>(){{
                    float firstY = random(0.8, 0.95) * height;
                    //
                    for(int i = from; i < to; i++){
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
                returnGraphic.mapLayersColorWithModel(CLM, from, to);
                break;
            ///
            default :
                returnGraphic = new GraphicLayer(id, new ArrayList<LayerScape>(){{
                    float firstY = random(0.78, 0.92) * height;
                    //
                    for(int i = from; i < to; i++){
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
                }});
                returnGraphic.mapLayersColorWithModel(CLM, from, to);
                break;	
        }
        //////
        //////

        return returnGraphic;
    }
}