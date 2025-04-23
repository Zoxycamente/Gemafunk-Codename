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
    FlxG.camera.pixelPerfectRender = true;
    FlxG.stage.quality = "low";
}