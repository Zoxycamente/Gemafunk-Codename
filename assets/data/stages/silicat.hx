function create() 
{

    for (char in [boyfriend, dad])
    {
        char.scale.set(0.02325581395, 0.02325581395);
        
        char.pixelPerfectPosition = true;
    }

    for (background in [bg, fg])
    {
        background.scale.set(0.09090909091, 0.09090909091);
        background.y -= 300;
        background.x += 20;
    
        background.pixelPerfectPosition = true;
    }

    dad.x += 1100;
    boyfriend.x += 500;

    FlxG.camera.antialiasing = false;
    FlxG.stage.quality = "low";

    FlxG.camera.addShader(colorShader);
    //colorShader.hue = 150;
    colorShader.saturation = -100;
    colorShader.contrast = 20;
}

var colorShader = new CustomShader("adjustColor");

var hues = [100, 60, 80, -20, -50, 0];

function beatHit(b)
{
    if (b % 4 == 0)
    {
        trace("new color!");

        colorShader.hue = hues[FlxG.random.int(0, hues.length)];
    }
}