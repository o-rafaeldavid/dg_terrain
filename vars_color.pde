final int sceneLightType = round(random(0, 1)); ////// 0: grande contraste / 1: contraste / 2: normal
final int sceneColorType = round(random(0, 2)); ////// 0: mono / 1: 2 pigmentos / 2: 3 pigmentos

final ArrayList<ArrayList<ColorPercentage>> monoHueTones = new ArrayList<ArrayList<ColorPercentage>>() {{
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
}};

ArrayList<Float> sceneLerpHues = new ArrayList<Float>() {{
    for (int i = 0; i < sceneColorType + 1; i++) {
        add(random(0, 360));
    }
}};

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

color exponentialLightLerp(color c, float factor, float firstContrast){
    color returnableColor;
    pushStyle();
        setHSB();
        float hue = hue(c);
        float saturation = saturation(c);
        float nextBrightness = log(map(factor, 0, 1, 1, 100)) / log(1.0471);

        nextBrightness = constrain(nextBrightness, firstContrast, 100);
        returnableColor = hslToHsb(hue, saturation, nextBrightness);
        println(red(returnableColor) + " / " + green(returnableColor) + " / " + blue(returnableColor));
    popStyle();
    return returnableColor;
}

color linearLightLerp(color c, float factor) {
    color returnableColor;
    pushStyle();
        setHSB();
        float hue = hue(c);
        float saturation = saturation(c);
        float nextBrightness = map(factor, 0, 1, 1, 100);

        nextBrightness = constrain(nextBrightness, 0, 100);
        returnableColor = hslToHsb(hue, saturation, nextBrightness);
        println(red(returnableColor) + " / " + green(returnableColor) + " / " + blue(returnableColor));
    popStyle();
    return returnableColor;
}

