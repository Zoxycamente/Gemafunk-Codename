var cards:FunkinSprite;
var cardCamera:FlxCamera = new FlxCamera();

function create() 
{
    trace("game/cards/" + curSong);
    FlxG.camera.bgColor = FlxColor.TRANSPARENT;

    FlxG.cameras.add(cardCamera, false);
    cardCamera.bgColor = FlxColor.TRANSPARENT;

    cards = new FunkinSprite(-400,300, Paths.image("game/cards/" + curSong));
    cards.cameras = [cardCamera];
    cards.scale.set(1.5,1.5);
    add(cards);
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
    }
}

function cardShit(piupiu:String) {
    switch(piupiu) {
        case "entra":
            trace("entrou");
            FlxTween.tween(cards, {x: 0}, 1, {ease: FlxEase.smootherStepOut});
        case "sai":
            trace("saiu");
            FlxTween.tween(cards, {x: cards.x-400}, 1, {ease: FlxEase.smootherStepin}, function() {
                destroy(cardCamera);
            });
    }
}