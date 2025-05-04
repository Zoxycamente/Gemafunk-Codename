var cards:FunkinSprite;
var xValue:String = "0";
var yValue:String = "300";
var cardCamera:FlxCamera = new FlxCamera();

function create() 
{
    trace("game/cards/" + curSong);
    FlxG.camera.bgColor = FlxColor.TRANSPARENT;

    FlxG.cameras.add(cardCamera, false);
    cardCamera.bgColor = FlxColor.TRANSPARENT;

    cards = new FunkinSprite(-800,330, Paths.image("game/cards/" + curSong));
    cards.cameras = [cardCamera];
    cards.antialiasing = true;
    //cards.scale.set(1.5,1.5);
    add(cards);

    switch(curSong) 
    {
        case "gemabot": 
            cards.scale.set(1.5,1.5);
            xValue = 40;
        case "4ever":
            cards.scale.set(0.5,0.5);
            cards.y = 130;
            xValue = -180;
        case "ghosttap":
            cards.scale.set(0.7,0.7);
            cards.y = 130;
            xValue = -130;
        case "silicat":
            cards.scale.set(1.5,1.5);
            cards.camera = camHUD;
        case "tibba":
            cards.scale.set(0.4, 0.4);
            cards.y = -100;
            xValue = -180;
    }
}

function stepHit(curStep) 
{
    switch(curSong) 
    {
        case "gemaplay":
            if (curStep == 213) cardShit("entra");
            if (curStep == 234) cardShit("sai");
        case "gemabot": 
            if (curStep == 16) cardShit("entra");
            if (curStep == 48) cardShit("sai");
        case "4ever":
            if (curStep == 114) cardShit("entra");
            if (curStep == 134) cardShit("sai");
        case "ghosttap":
            if (curStep == 320) cardShit("entra");
            if (curStep == 344) cardShit("sai");
        case "silicat":
            if (curStep == 292) cardShit("entra");
            if (curStep == 320) cardShit("sai");
        case "tibba":
            if (curStep == 130) cardShit("entra");
            if (curStep == 160) cardShit("sai");
    }
}

function cardShit(piupiu:String) 
{
    switch(piupiu) 
    {
        case "entra":
            trace(xValue);
            trace("entrou");
            FlxTween.tween(cards, {x: xValue}, 1, {ease: FlxEase.smootherStepOut});
        case "sai":
            trace("saiu");
            FlxTween.tween(cards, {x: cards.x-800}, 1, {ease: FlxEase.quadIn}, function() {
                destroy(cards);
            });
    }
}