final int sceneLightType = round(random(0, 1)); ////// 0: grande contraste / 1: contraste / 2: normal
final int sceneColorType = round(random(0, 2)); ////// 0: mono / 1: 2 pigmentos / 2: 3 pigmentos

//////

final ArrayList<ArrayList<ColorPercentage>> tones = new ArrayList<ArrayList<ColorPercentage>>() {{
    //
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(37, 22, 16, 255), 0.0f));
      add(new ColorPercentage(color(161, 129, 106, 255), 0.7f));
      add(new ColorPercentage(color(250, 234, 221, 255), 1.0f));
    }});
    // 
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(114, 46, 25, 255), 0.0f));
      add(new ColorPercentage(color(168, 91, 36, 255), 0.2f));
      add(new ColorPercentage(color(220, 166, 80, 255), 0.5f));
      add(new ColorPercentage(color(241, 218, 165, 255), 1.0f));
    }});
    // 
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(68, 35, 20, 255), 0.0f));
      add(new ColorPercentage(color(99, 54, 25, 255), 0.35f));
      add(new ColorPercentage(color(220, 137, 24, 255), 1.0f));
    }});
    // 
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(112, 95, 93, 255), 0.0f));
      add(new ColorPercentage(color(162, 133, 130, 255), 0.3f));
      add(new ColorPercentage(color(79, 85, 100, 255), 0.6f));
      add(new ColorPercentage(color(48, 60, 75, 255), 1.0f));
    }});
    // 
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(23, 41, 55, 255), 0.0f));
      add(new ColorPercentage(color(56, 73, 89, 255), 0.2f));
      add(new ColorPercentage(color(75, 92, 102, 255), 0.75f));
      add(new ColorPercentage(color(127, 133, 133, 255), 1.0f));
    }});
    // 
    add(new ArrayList<ColorPercentage>(){{
      add(new ColorPercentage(color(17, 29, 26, 255), 0.0f));
      add(new ColorPercentage(color(32, 41, 32, 255), 0.65f));
      add(new ColorPercentage(color(30, 50, 60, 255), 0.651f));
      add(new ColorPercentage(color(63, 76, 84, 255), 0.8f));
      add(new ColorPercentage(color(94, 96, 98, 255), 1.0f));
    }});
}};

final ArrayList<Gradient> sky = new ArrayList<Gradient>();
void SKY(){
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(0, PI / 6),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(253, 228, 203, 0), 0.0f));
            add(new ColorPercentage(color(255, 246, 216, 200), 0.5f));
            add(new ColorPercentage(color(255, 246, 216, 255), 1.0f));
        }}
    ));
    //
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(0, PI / 6),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(251, 241, 229, 0), 0.0f));
            add(new ColorPercentage(color(233, 209, 190, 140), 1.0f));
        }}
    ));
    //
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(PI / 8, QUARTER_PI),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(253, 223, 91, 32), 0.0f));
            add(new ColorPercentage(color(251, 177, 27, 100), 1.0f));
        }}
    ));
    //
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(0, PI / 6),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(255, 247, 235, 16), 0.0f));
            add(new ColorPercentage(color(223, 181, 163, 40), 0.5f));
            add(new ColorPercentage(color(106, 92, 95, 70), 1.0f));
        }}
    ));
    //
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(0, PI / 9),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(217, 218, 204, (lightKind == "EXP") ? 72 : 128), (lightKind == "EXP") ? 1.0f : 0.0f));
            add(new ColorPercentage(color(123, 123, 120, (lightKind == "EXP") ? 42 : 200), (lightKind == "EXP") ? 0.0f : 1.0f));
        }}
    ));
    //
    sky.add(new Gradient(
        true,
        new PVector(0, 0),
        random(0, PI / 6),
        new ArrayList<ColorPercentage>(){{
            add(new ColorPercentage(color(79, 101, 115, 80), 0.0f));
            add(new ColorPercentage(color(113, 121, 131, 200), 0.5f));
            add(new ColorPercentage(color(122, 118, 118, 255), 1.0f));
        }}
    ));
}

void SETUP_SKY(){
    SKY();
    if(sky.size() != tones.size()){
        println("sky and tones should be at the same size");
        exit();
    }
}

//////

ArrayList<Float> sceneLerpHues = new ArrayList<Float>() {{
    for (int i = 0; i < sceneColorType + 1; i++) {
        add(random(0, 360));
    }
}};

//////

void setHSB() { colorMode(HSB, 360, 100, 100); }

color hslToHsb(float hue, float sat, float light) {
    float s = sat / 100.0f;
    float l = light / 100.0f;
    pushStyle();
        setHSB();
        float b = l + s * min(l, 1 - l);
        float newS = (b == 0) ? 0 : 2 * (1 - l / b);
        color retColor = color(hue, newS * 100, b * 100);

    popStyle();
    return retColor;
}

color exponentialLightLerp(color c, float factor, float from, float to){
    color returnableColor;
    pushStyle();
        setHSB();
        float hue = hue(c);
        float saturation = saturation(c);
        float nextBrightness = log(map(factor, 0, 1, from, to)) / log(1.0471);

        nextBrightness = constrain(nextBrightness, 0, 100);
        returnableColor = hslToHsb(hue, saturation, nextBrightness);
        println(red(returnableColor) + " / " + green(returnableColor) + " / " + blue(returnableColor));
    popStyle();
    return returnableColor;
}

color linearLightLerp(color c, float factor, float from, float to) {
    color returnableColor;
    pushStyle();
        setHSB();
        float hue = hue(c);
        float saturation = saturation(c);
        float nextBrightness = map(factor, 0, 1, from, to);

        nextBrightness = constrain(nextBrightness, 0, 100);
        returnableColor = hslToHsb(hue, saturation, nextBrightness);
        println(red(returnableColor) + " / " + green(returnableColor) + " / " + blue(returnableColor));
    popStyle();
    return returnableColor;
}

