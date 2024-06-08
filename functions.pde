HashMap<String, GraphicLayer> __terrains;

void SETUP__terrains(){
    __terrains = new HashMap<String, GraphicLayer>();
    /////
    /////
    __terrains.put(
        "Dune",
        new GraphicLayer(0, new ArrayList<>() {{
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
                    true
                ));
                firstY -= random(
                    map(CLM.getList().size(), 0, 10, 0.07, 0.01),
                    map(CLM.getList().size(), 0, 10, 0.14, 0.07)
                ) * height;
            }
        }})
    );
    /////
    /////
    __terrains.put(
        "Mountain Dune",
        new GraphicLayer(1, new ArrayList<>() {{
            float firstY = random(0.78, 0.92) * height;
            float clmSize = CLM.getList().size();
            //
            for(int i = 0; i < clmSize; i++){
                boolean checkMountain = (i >= clmSize * 0.7);
                println(i);
                println(checkMountain);
                PVector minMax = new PVector(
                    map(i, 0, CLM.getList().size(), (checkMountain) ? 90 : 10, (checkMountain) ? 90 : 30),
                    map(i, 0, CLM.getList().size(), (checkMountain) ? 100 : 50, (checkMountain) ? 170 : 80)
                );
                add(new LayerScape(
                    int(random((checkMountain) ? 5 : 3, (checkMountain) ? 14 : 6)), color(0),
                    new float[] {
                        -1 * random(minMax.x, minMax.y),
                        random(minMax.x, minMax.y)
                    },
                    firstY,
                    1,
                    (checkMountain) ? false : true
                ));
                firstY -= random(
                    map(CLM.getList().size(), 0, 10, (checkMountain) ? 0.2 : 0.05, (checkMountain) ? 0.1 : 0.01),
                    map(CLM.getList().size(), 0, 10, (checkMountain) ? 0.25 : 0.09, (checkMountain) ? 0.2 : 0.05)
                ) * height;
            }
        }})
    );
}