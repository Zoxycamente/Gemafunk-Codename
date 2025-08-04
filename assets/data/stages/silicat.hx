function create() 
{
    importScript("data/scripts/pixel");
    importScript("data/scripts/silicatHUD");

    
    for (char in [boyfriend, dad])
    {
        char.scale.set(0.02825581395, 0.02825581395);
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
    catHUD.addShader(colorShader);

    pixelShader.pixelSize = 0.001;

    //colorShader.hue = 150;
    //colorShader.saturation = -100;
    //colorShader.brightness = 20;

}

function onGameOver(e)
{
    inGameover = true;
    camGame.x = 0;
    camGame.zoom = 0.2;
}

var inGameover:Bool = false;

function postUpdate()
{
    if (!inGameover)
    {
        camGame.zoom = 7;
        camGame.x = 330;
    }
}

var colorShader = new CustomShader("adjustColor");
var pixelShader = new CustomShader("pixel");

var hues = [0, -110, 10, 140];
var saturations = [10, 30, 50, -20];
var grayscale = false;

var curColor:Int = 0;

function beatHit(b)
{
    if (b % 24 == 0 && b > 1 && !grayscale)
    {
        curColor = FlxG.random.int(0, hues.length-1, [curColor]);


        colorShader.hue = hues[curColor];
        colorShader.saturation = saturations[curColor];

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
    {
        colorShader.saturation = -100;
    }
    else
    {
        colorShader.saturation =  0;
        FlxTween.num(100, 0, 1.2, {ease: FlxEase.quintOut}, function(x) colorShader.contrast = x);
    }
}