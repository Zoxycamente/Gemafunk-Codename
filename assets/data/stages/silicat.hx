function create() 
{
    importScript("data/scripts/pixel");
    
    for (char in [boyfriend, dad])
    {
        char.scale.set(0.02325581395, 0.02325581395);
        char.pixelPerfectPosition = true;
    }

    for (background in [bg, fg])
    {
        background.scale.set(0.08090909091, 0.08090909091);
        background.y -= 292;
        background.x += 20;
    
        background.pixelPerfectPosition = true;
    }

    dad.x += 1110;
    boyfriend.x += 495;

    FlxG.camera.antialiasing = false;
    FlxG.stage.quality = "low";

    FlxG.camera.addShader(pixelShader);
    FlxG.camera.addShader(colorShader);
    camHUD.addShader(colorShader);

    pixelShader.pixelSize = 0.001;

    //colorShader.hue = 150;
    //colorShader.saturation = -100;
    colorShader.brightness = 20;
}

var colorShader = new CustomShader("adjustColor");
var pixelShader = new CustomShader("pixel");

var hues = [100, 60, 80, -20, -50, 0];
var grayscale = false;

function beatHit(b)
{
    if (b % 24 == 0 && b > 1 && !grayscale)
    {
        colorShader.hue = hues[FlxG.random.int(0, hues.length-1)];

        FlxTween.num(100, 0, 1.2, {ease: FlxEase.quintOut}, function(x) colorShader.contrast = x);
    }
}

function tweenShader(isIn:Bool, speed:Float, amount:Float)
{
    if (isIn)
        FlxTween.num(0.001, amount, speed, {ease: FlxEase.quartOut, onComplete: () -> pixelShader.pixelSize = amount}, function(x) pixelShader.pixelSize = x);
    else
        FlxTween.num(amount, 0.001, speed, {ease: FlxEase.quartOut, onComplete: () -> pixelShader.pixelSize = 0.001}, function(x) pixelShader.pixelSize = x);
}

function activeGrayscale()
{
    grayscale = !grayscale;

    if (grayscale)
        colorShader.saturation = -100;
    else
    {
        colorShader.saturation =  0;
        FlxTween.num(100, 0, 1.2, {ease: FlxEase.quintOut}, function(x) colorShader.contrast = x);
    }
}